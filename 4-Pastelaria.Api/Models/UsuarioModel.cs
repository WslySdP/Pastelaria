﻿using Pastelaria.Domain.Tarefa.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace _4_Pastelaria.Api.Models
{
    public class UsuarioModel
    {
        public int Id { get; set; }
        public int CodigoTipoUsuario { get; set; }
        public string Email { get; set; }
        public string Senha { get; set; }
        public string Nome { get; set; }
        public DateTime? DataNascimento { get; set; }
        public string Telefonefixo { get; set; }
        public string TelefoneCelular { get; set; }
        public string Logradouro { get; set; }
        public string Bairro { get; set; }
        public string Cidade { get; set; }
        public string Uf { get; set; }
        public string Cep { get; set; }
        public string Foto { get; set; }
        public IEnumerable<TarefaDto> Tarefas { get ;  set; }

    }
}