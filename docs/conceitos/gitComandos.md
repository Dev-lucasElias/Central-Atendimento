# Git — Comandos Usados no Projeto

## Fluxo do dia a dia

```bash
# ver status do repositório
git status

# preparar arquivos para commit
git add nome-do-arquivo
git add -A  # adiciona tudo

# commitar
git commit -m "mensagem do commit"

# subir para o remoto
git push origin nome-da-branch

# atualizar local com o remoto
git pull origin master
```

---

## Branches

```bash
# criar e já mudar para a nova branch
git checkout -b nome-da-branch

# mudar para uma branch existente
git checkout nome-da-branch

# ver branches existentes
git branch
```

---

## Remoto

```bash
# ver remotos configurados
git remote -v

# buscar mudanças do remoto sem aplicar
git fetch origin

# ver commits do remoto
git log --oneline origin/master
```

---

## GitHub CLI (gh)

```bash
# criar pull request
gh pr create --title "título" --body "closes #numero" --base master

# fazer merge de um PR existente
gh pr merge 51 --merge
gh pr merge 51 --rebase   # merge com rebase
```

---

## ⚠️ Os que tenho mais dificuldade

| Comando | O que faz | Erro comum |
|---|---|---|
| `git pull origin master` | Atualiza o local com o remoto | Esquecer o `origin master` ou digitar `git pul` |
| `git push origin nome-da-branch` | Sobe a branch para o remoto | Esquecer o nome da branch |
| `git checkout -b nova-branch` | Cria e muda para nova branch | Confundir com `git branch` que só cria |
| `gh pr create --base master` | Cria PR definindo branch de destino | Usar `--rebase` (não existe nesse comando) |
| `gh pr merge 51 --merge` | Faz merge de um PR pelo número | Tentar usar `gh pr create` para fazer merge |
