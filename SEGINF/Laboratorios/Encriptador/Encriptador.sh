echo "Ingrese la ruta al archivo: "
read path

#check if path is not empty string
if [ -z "$path" ]
then
  echo "La ruta esta vacia..."
  exit
fi
#check if file exist

if [ ! -e "$path" ] 
then
  echo "El archivo no existe..."
  exit
fi

gpg -c --cipher-algo AES256 --symmetric "$path"

echo RELOADAGENT | gpg-connect-agent


