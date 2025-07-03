from fastapi import FastAPI
from database import engine, Base
from routers.alunos import alunos_router
from routers.cursos import cursos_router
from routers.matriculas import matriculas_router

# Criação das tabelas no banco de dados
Base.metadata.create_all(bind=engine)

# Inicialização do FastAPI
app = FastAPI(
    title="API de Gestão Escolar",
    description="""
        Esta API fornece endpoints para gerenciar alunos, cursos e matrículas em uma instituição de ensino.
        
        Com ela, é possível realizar operações como:
        - Cadastro de alunos
        - Criação e consulta de cursos
        - Matrícula de alunos em turmas
    """, 
    version="1.0.0",
)

# Inclusão dos routers
app.include_router(alunos_router, tags=["Alunos"])
app.include_router(cursos_router, tags=["Cursos"])
app.include_router(matriculas_router, tags=["Matrículas"])

@app.get("/", tags=["Status"])
def root():
    return {"message": "API de Gestão Escolar está rodando com sucesso! 🚀"}
