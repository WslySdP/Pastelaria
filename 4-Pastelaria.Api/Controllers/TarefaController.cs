﻿using _5_Pastelaria.Repository.Repositories;
using _6_Pastelaria.Services;
using _6_Pastelaria.Services.Services;
using Pastelaria.Domain.Tarefa;
using Pastelaria.Domain.Tarefa.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace _4_Pastelaria.Api.Controllers
{
    [RoutePrefix("api/Tarefa")]
    public class TarefaController : ApiController
    {
        private readonly ITarefaRepository _tarefaRepository;
        private readonly ITarefaService _tarefaService;

        public TarefaController(ITarefaRepository iTarefaRepository, ITarefaService tarefaService)
        {
            _tarefaRepository = iTarefaRepository;
            _tarefaService = tarefaService;
        }

        /// <summary>
        /// Método que obtém os dados da tarefa de acordo com sua Id
        /// </summary>
        /// <param name="id">Id da tarefa a ser retornada</param>
        /// <returns>Se id existe retona os dados da tarefa</returns>
        [HttpGet, Route("selecionar-tarefa/{id}")]
        public IHttpActionResult GetTarefaPorId(int id)
        {
            try
            {
                var tarefa = _tarefaRepository.GetTarefaPorId(id);
                return Ok(tarefa);
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao retornar tarefa!" + ex.Message);
            }
        }

        /// <summary>
        /// Médoto que chama o serviço para inserir os dados da tarefa
        /// </summary>n
        /// <param name="tarefaDto">Parametros com os dados da tarefa</param>
        /// <returns>Se a inserção for bem sucedida retorna um status ok</returns>
        [HttpPost,Route("tarefa/")]
        public IHttpActionResult Post(TarefaDto tarefaDto)
        {
            try
            {
                var tarefa = _tarefaService.Post(tarefaDto);
                if (!string.IsNullOrEmpty(tarefa))
                    return BadRequest(tarefa);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao inserir tarefa!" + ex.Message);
            }
        }

        /// <summary>
        /// Método que chama o serviço para atualizar a data de execução da tarefa
        /// </summary>
        /// <param name="id">Identificador da tarefa que deseja finalizar</param>
        /// <returns>Se a execução for bem sucedida retorna um status de ok</returns>
        [HttpPut,Route("finalizar-tarefa/{id}")]
        public IHttpActionResult PutDataExecucao(int id)
        {
            try
            {
                _tarefaService.PutDataExecucao(id);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao finalizar tarefa!" + ex.Message);
            }
        }

        [HttpDelete, Route("deletar-tarefa/{id}")]
        public IHttpActionResult DeleteTarefaPorId(int id)
        {
            try
            {
                _tarefaService.Delete(id);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao finalizar tarefa!" + ex.Message);
            }
        }

        [HttpPut, Route("atualizar-tarefa/")]
        public IHttpActionResult PutTarefaPorId(int id, string tarefaDescricao, DateTime dataLimiteExecucao)
        {
            try
            {
                _tarefaService.PutTarefaPorId(id, tarefaDescricao, dataLimiteExecucao);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao atualizar tarefa!" + ex.Message);
            }
        }

        [HttpGet, Route("selecionar-tarefas/{idUsuario}")]
        public IHttpActionResult GetTarefas(int idUsuario)
        {
            try
            {
                var tarefas = _tarefaRepository.GetTarefas(idUsuario);
                return Ok(tarefas);
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao retornar tarefa!" + ex.Message);
            }
        }

        [HttpGet, Route("selecionar-tarefas-gestor/{idGestor}")]
        public IHttpActionResult GetTarefasPorIdGestor(int idGestor)
        {
            try
            {
                var tarefas = _tarefaRepository.GetTarefasPorIdGestor(idGestor);
                return Ok(tarefas);
            }
            catch (Exception ex)
            {
                return BadRequest("Falha ao retornar tarefa!" + ex.Message);
            }
        }
    }
}