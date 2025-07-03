# Usando a imagem base oficial do Python 3.10 com tamanho reduzido
# O 'slim' é uma versão mais leve da imagem do Python
FROM python:3.10-slim

# Definindo o diretório de trabalho dentro do contêiner para '/app'
# Tudo o que for feito após isso será relativo a esse diretório
WORKDIR /app

# Copiando o arquivo 'requirements.txt' da máquina local para o diretório de trabalho no contêiner
# Esse arquivo contém as dependências do projeto
COPY requirements.txt .

# Instalando as dependências listadas em 'requirements.txt' 
# O flag '--no-cache-dir' impede que o pip armazene arquivos de cache, economizando espaço
RUN pip install --no-cache-dir -r requirements.txt

# Copiando todos os arquivos do diretório local para o diretório de trabalho no contêiner
# Isso inclui o código da aplicação e outros arquivos necessários (ex: app.py, models.py)
COPY . .

# Expondo a porta 5000 para o contêiner, caso haja algum serviço rodando nessa porta
# Mas no seu caso, o FastAPI estará ouvindo na porta 8000 (do CMD)
EXPOSE 5000

# Comando para rodar o servidor Uvicorn com o FastAPI:
# - 'app:app' indica que o FastAPI está no arquivo 'app.py' e a variável FastAPI é chamada 'app'
# - '--host 0.0.0.0' faz o servidor aceitar conexões de todas as interfaces (necessário no contêiner)
# - '--port 8000' define a porta que o FastAPI vai escutar
# - '--reload' ativa o modo de recarga automática do servidor (útil para desenvolvimento)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
