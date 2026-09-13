SECRETS_FILES=$(find -name '*secret*.yml')

for file in $SECRETS_FILES; do
  if [[ -f ${file} ]]; then
    header=$(head -1 "${file}")
    if [[ "${header}" != '$ANSIBLE_VAULT'* ]]; then
      echo "Running: ansible-vault encrypt ${file}"
      ansible-vault encrypt ${file}
      res=$?
      if [[ $res == 0 ]]; then
        echo "Encrypted ${file}"
      else
        echo "Failed to encrypt ${file}"
      fi
    fi
  fi
done