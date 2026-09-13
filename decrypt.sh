SECRETS_FILES=$(find -name '*secret*.yml')

for file in $SECRETS_FILES; do
  if [[ -f ${file} ]]; then
    header=$(head -1 "${file}")
    if [[ "${header}" == '$ANSIBLE_VAULT'* ]]; then
      echo "Running: ansible-vault decrypt ${file}"
      ansible-vault decrypt ${file}
      res=$?
      if [[ $res == 0 ]]; then
        echo "Decrypted ${file}"
      else
        echo "Failed to decrypt ${file}"
      fi
    fi
  fi
done