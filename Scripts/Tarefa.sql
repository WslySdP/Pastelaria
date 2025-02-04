IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_InsTarefa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PSP_InsTarefa]
GO

CREATE PROCEDURE [dbo].[PSP_InsTarefa]
	@IdGestor int,
	@IdUsuario int,
	@TarefaDescricao varchar(200) = null,
	@DataLimiteExecucao date = null,
	@DataExecucao date = null,
	@Situacao varchar(20)
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Insere uma nova Tarefa
	Autor.............: SMN - Wesley Silveira
 	Data..............: 08/07/2021
	Ex................: EXEC [dbo].[PSP_InsTarefa]

	*/

	BEGIN;

		INSERT INTO [dbo].[Tarefa] (IdGestor, IdUsuario, TarefaDescricao, DataAgendamento, DataLimiteExecucao, DataExecucao, Situacao)
			VALUES(@IdGestor,@IdUsuario,@TarefaDescricao,Convert(date,SYSDATETIME()),@DataLimiteExecucao,@DataExecucao, @Situacao)

		RETURN SCOPE_IDENTITY()

	END;
GO
			

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_SelTarefaPorId]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PSP_SelTarefaPorId]
GO

CREATE PROCEDURE [dbo].[PSP_SelTarefaPorId]
	@Id int
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Busca a tarefa por um Id informado
	Autor.............: SMN - Wesley Silveira
 	Data..............: 08/07/2021
	Ex................: EXEC [dbo].[PSP_SelTarefaPorId]

	*/

	BEGIN;

		-- nolock em todas tabelas da proc
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
		
		SELECT Id, 
				IdGestor, 
				IdUsuario, 
				TarefaDescricao, 
				DataAgendamento, 
				DataLimiteExecucao, 
				DataExecucao,
				Situacao
			FROM [dbo].[Tarefa]
			WHERE Id = @Id

	END;
GO
				

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_UpdDataExecucaoTarefa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PSP_UpdDataExecucaoTarefa]
GO

CREATE PROCEDURE [dbo].[PSP_UpdDataExecucaoTarefa]
	@Id int
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Atualiza a data da execu��o da tabela Tarefa.
	Autor.............: SMN - Wesley Silveira
 	Data..............: 12/07/2021
	Ex................: BEGIN TRANSACTION
							EXEC [dbo].[PSP_UpdDataExecucaoTarefa]30
							SELECT * FROM Tarefa 
						ROLLBACK TRANSACTION

	*/

	BEGIN;

		UPDATE [dbo].[Tarefa]
			SET DataExecucao = CAST(GETDATE() AS DATE)
			WHERE Id = @Id

	END;
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_UpdSituacaoTarefa]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PSP_UpdSituacaoTarefa]
GO

CREATE PROCEDURE [dbo].[PSP_UpdSituacaoTarefa]
    @Id int,
	@Situacao varchar(20) = NULL
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Cancela a tarefa mudando sua situa��o
	Autor.............: SMN - Wesley Silveira
 	Data..............: 19/08/2021
	Ex................: EXEC [dbo].[PSP_UpdSituacaoTarefa]

	*/

	BEGIN;
		
		UPDATE [dbo].[Tarefa]
			SET Situacao = @Situacao
			WHERE Id = @Id

	END;
GO
				
				

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_DeleteTarefaPorId]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PSP_DeleteTarefaPorId]
GO

CREATE PROCEDURE [dbo].[PSP_DeleteTarefaPorId]
@Id int
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Deletar tarefa pelo Id iformado
	Autor.............: SMN - Wesley Silveira
 	Data..............: 19/08/2021
	Ex................: EXEC [dbo].[PSP_DeleteTarefaPorId]

	*/

	BEGIN;

		DELETE FROM [dbo].[Tarefa] 
			WHERE Id = @Id;

	END;
GO
				

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_UPDTarefaPorId]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].[PSP_UPDTarefaPorId]
GO

CREATE PROCEDURE [dbo].[PSP_UPDTarefaPorId]
	@TarefaDescricao varchar(200) = null,
	@DataLimiteExecucao date = null,
	@Id int
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Atualiza as informa��es da tarefa de acordo com o Id informado
	Autor.............: SMN - Wesley Silveira
 	Data..............: 20/08/2021
	Ex................: EXEC [dbo].[PSP_UPDTarefaPorId]

	*/

	BEGIN;

		UPDATE [dbo].[Tarefa]
			SET TarefaDescricao = @TarefaDescricao, DataLimiteExecucao = @DataLimiteExecucao
			WHERE Id = @Id

	END;
GO
			
CREATE PROCEDURE [dbo].[PSP_SelTarefasUsuario]
	@IdUsuario int
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Busca todas as tarefas de um usu�rio informado
	Autor.............: SMN - Wesley Silveira
 	Data..............: 08/07/2021
	Ex................: EXEC [dbo].[PSP_SelTarefasUsuario]

	*/

	BEGIN;

		-- nolock em todas tabelas da proc
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		SELECT Id, 
				IdGestor, 
				IdUsuario, 
				TarefaDescricao, 
				DataAgendamento, 
				DataLimiteExecucao, 
				DataExecucao,
				Situacao
			FROM [dbo].[Tarefa]
			WHERE IdUsuario = @IdUsuario
			ORDER BY DataAgendamento DESC

	END;
GO


IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[PSP_SelTarefasUsuarioPorIdGestor]') AND objectproperty(id, N'IsPROCEDURE')=1)
	DROP PROCEDURE [dbo].PSP_SelTarefasUsuarioPorIdGestor
GO

CREATE PROCEDURE [dbo].PSP_SelTarefasUsuarioPorIdGestor
@IdGestor int
	AS

	/*
	Documentacao
	Arquivo Fonte.....: Tarefa.sql
	Objetivo..........: Busca todas as tarefas de um gestor informado
	Autor.............: SMN - Wesley Silveira
 	Data..............: 26/08/2021
	Ex................: EXEC [dbo].[PSP_SelTarefasUsuarioPorIdGestor]

	*/

	BEGIN;

		-- nolock em todas tabelas da proc
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

		SELECT Id, 
				IdGestor, 
				IdUsuario, 
				TarefaDescricao, 
				DataAgendamento, 
				DataLimiteExecucao, 
				DataExecucao,
				Situacao
			FROM [dbo].[Tarefa]
			WHERE IdGestor = @IdGestor
			ORDER BY DataAgendamento DESC

	END;
GO