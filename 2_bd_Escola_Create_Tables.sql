--
-- Database: `bd_Escola`
--

--
-- Estrutura da tabela `Aluno`
--

CREATE TABLE IF NOT EXISTS `Aluno` (
  `cod_pessoa` int(11) NOT NULL,
  `matricula` int(11) NOT NULL,
  `dt_nascimento` date NOT NULL,
  `cod_turma` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Cidade`
--

CREATE TABLE IF NOT EXISTS `Cidade` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Contato`
--

CREATE TABLE IF NOT EXISTS `Contato` (
  `nome` varchar(30) NOT NULL,
  `cod_aluno` int(11) NOT NULL,
  `telefone` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Disciplina`
--

CREATE TABLE IF NOT EXISTS `Disciplina` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Escola`
--

CREATE TABLE IF NOT EXISTS `Escola` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cod_cidade` int(11) NOT NULL,
  `cod_professor` int(11) NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Ministra`
--

CREATE TABLE IF NOT EXISTS `Ministra` (
  `cod_disciplina` int(11) NOT NULL,
  `cod_professor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Pessoa`
--

CREATE TABLE IF NOT EXISTS `Pessoa` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `cod_cidade` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Professor`
--

CREATE TABLE IF NOT EXISTS `Professor` (
  `cod_pessoa` int(11) NOT NULL,
  `rg` varchar(9) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `titulo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `ProfessoresAtivos`
--

CREATE TABLE IF NOT EXISTS `ProfessoresAtivos` (
  `cod_professor` int(11) NOT NULL,
  `cod_turma` int(11) NOT NULL,
  `cod_disciplina` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Estrutura da tabela `Turma`
--

CREATE TABLE IF NOT EXISTS `Turma` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(30) NOT NULL,
  `cod_escola` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--
--
-- Indexes for table `Aluno`
--
ALTER TABLE `Aluno`
  ADD PRIMARY KEY (`cod_pessoa`),
  ADD UNIQUE KEY `matricula` (`matricula`),
  ADD KEY `fk_turma_aluno` (`cod_turma`);

--
-- Indexes for table `Cidade`
--
ALTER TABLE `Cidade`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `Contato`
--
ALTER TABLE `Contato`
  ADD PRIMARY KEY (`nome`,`cod_aluno`),
  ADD KEY `fk_aluno` (`cod_aluno`);

--
-- Indexes for table `Disciplina`
--
ALTER TABLE `Disciplina`
  ADD PRIMARY KEY (`codigo`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Indexes for table `Escola`
--
ALTER TABLE `Escola`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_cidade_escola` (`cod_cidade`),
  ADD KEY `fk_professor_escola` (`cod_professor`);

--
-- Indexes for table `Ministra`
--
ALTER TABLE `Ministra`
  ADD PRIMARY KEY (`cod_disciplina`,`cod_professor`),
  ADD KEY `fk_professor_ministra` (`cod_professor`);

--
-- Indexes for table `Pessoa`
--
ALTER TABLE `Pessoa`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_cidade_pessoa` (`cod_cidade`);

--
-- Indexes for table `Professor`
--
ALTER TABLE `Professor`
  ADD PRIMARY KEY (`cod_pessoa`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD UNIQUE KEY `rg` (`rg`);

--
-- Indexes for table `ProfessoresAtivos`
--
ALTER TABLE `ProfessoresAtivos`
  ADD PRIMARY KEY (`cod_professor`,`cod_turma`,`cod_disciplina`),
  ADD KEY `fk_turma_ativos` (`cod_turma`),
  ADD KEY `fk_disciplina_ativos` (`cod_disciplina`);

--
-- Indexes for table `Turma`
--
ALTER TABLE `Turma`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_escola` (`cod_escola`);

  
--
-- AUTO_INCREMENT for table `Cidade`
--
ALTER TABLE `Cidade`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Disciplina`
--
ALTER TABLE `Disciplina`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `Escola`
--
ALTER TABLE `Escola`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `Pessoa`
--
ALTER TABLE `Pessoa`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=415;
--
-- AUTO_INCREMENT for table `Turma`
--
ALTER TABLE `Turma`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
  

--
-- Constraints for dumped tables
--
--
-- Limitadores para a tabela `Aluno`
--
ALTER TABLE `Aluno`
  ADD CONSTRAINT `fk_pessoa_aluno` FOREIGN KEY (`cod_pessoa`) REFERENCES `Pessoa` (`codigo`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_turma_aluno` FOREIGN KEY (`cod_turma`) REFERENCES `Turma` (`codigo`);
--
-- Limitadores para a tabela `Contato`
--
ALTER TABLE `Contato`
  ADD CONSTRAINT `fk_aluno` FOREIGN KEY (`cod_aluno`) REFERENCES `Aluno` (`cod_pessoa`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Limitadores para a tabela `Escola`
--
ALTER TABLE `Escola`
  ADD CONSTRAINT `fk_cidade_escola` FOREIGN KEY (`cod_cidade`) REFERENCES `Cidade` (`codigo`),
  ADD CONSTRAINT `fk_professor_escola` FOREIGN KEY (`cod_professor`) REFERENCES `Professor` (`cod_pessoa`) ON DELETE SET NULL ON UPDATE RESTRICT;

--
-- Limitadores para a tabela `Ministra`
--
ALTER TABLE `Ministra`
  ADD CONSTRAINT `fk_disciplina` FOREIGN KEY (`cod_disciplina`) REFERENCES `Disciplina` (`codigo`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_professor_ministra` FOREIGN KEY (`cod_professor`) REFERENCES `Professor` (`cod_pessoa`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Limitadores para a tabela `Pessoa`
--
ALTER TABLE `Pessoa`
  ADD CONSTRAINT `fk_cidade_pessoa` FOREIGN KEY (`cod_cidade`) REFERENCES `Cidade` (`codigo`);

--
-- Limitadores para a tabela `Professor`
--
ALTER TABLE `Professor`
  ADD CONSTRAINT `fk_pessoa_professor` FOREIGN KEY (`cod_pessoa`) REFERENCES `Pessoa` (`codigo`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Limitadores para a tabela `ProfessoresAtivos`
--
ALTER TABLE `ProfessoresAtivos`
  ADD CONSTRAINT `fk_disciplina_ativos` FOREIGN KEY (`cod_disciplina`) REFERENCES `Disciplina` (`codigo`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_professor_ativos` FOREIGN KEY (`cod_professor`) REFERENCES `Professor` (`cod_pessoa`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_turma_ativos` FOREIGN KEY (`cod_turma`) REFERENCES `Turma` (`codigo`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Limitadores para a tabela `Turma`
--
ALTER TABLE `Turma`
  ADD CONSTRAINT `fk_escola` FOREIGN KEY (`cod_escola`) REFERENCES `Escola` (`codigo`) ON DELETE CASCADE ON UPDATE RESTRICT;
