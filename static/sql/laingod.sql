-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 07-11-2023 a las 14:01:03
-- Versión del servidor: 5.7.43-log
-- Versión de PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `laingod`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `idcomentario` int(11) NOT NULL,
  `contenido` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galera`
--

CREATE TABLE `galera` (
  `IdIMG` int(11) NOT NULL,
  `rutaimg` varchar(100) NOT NULL,
  `Tituloimg` varchar(200) NOT NULL,
  `Descripcion` varchar(5000) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `FechaS` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `galera`
--

INSERT INTO `galera` (`IdIMG`, `rutaimg`, `Tituloimg`, `Descripcion`, `FechaS`) VALUES
(1, 'img/galeria/descargar_1VCVSF.jpg', 'payasa', 'xd', '2023-11-06 03:15:19'),
(2, 'img/galeria/descargar_1DDCVN.jpg', 'payasa', 'xd', '2023-11-06 03:15:42'),
(3, 'img/galeria/A_poco_si_muy_vergasCNSFB.jpg', 'a poco si muy verga ', 'popo', '2023-11-06 03:16:15'),
(4, 'img/galeria/descargarNSCJD.ico', 'luis', '22', '2023-11-06 03:18:57'),
(5, 'img/galeria/marcosNKDSS.jpg', 'marcos', 'marquitos', '2023-11-06 16:00:57'),
(6, 'img/galeria/susDVKND.jpg', 'tanque', 'tanque', '2023-11-06 16:01:25'),
(7, 'img/galeria/tiger2SKSLV.jpeg', 'ti', '', '2023-11-06 16:04:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gpersonal`
--

CREATE TABLE `gpersonal` (
  `NumIMG` int(11) NOT NULL,
  `idususario` int(11) NOT NULL,
  `ruta` mediumblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `Nombreu` varchar(50) COLLATE utf32_spanish_ci NOT NULL,
  `correou` varchar(50) COLLATE utf32_spanish_ci NOT NULL,
  `claveu` longtext COLLATE utf32_spanish_ci NOT NULL,
  `perfilu` varchar(1) COLLATE utf32_spanish_ci NOT NULL DEFAULT 'C'
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `Nombreu`, `correou`, `claveu`, `perfilu`) VALUES
(1, 'tadeo', 'pop@tu.corazon', 'pbkdf2:sha256:600000$mKnAglLRGvs4HlWm$bf99692fe55f9a24255a85c0124ecff78fbbacdc2352d2529278ce255d0d0efb', 'A'),
(2, 'tadeo', 'tadeofrancisco36@gmail.com', 'pbkdf2:sha256:600000$9BMFCKqTgYMk6eZn$bab79339761acf914436bb73702696ea6bf649a05c823637acd476dac186b0dd', 'C'),
(3, 'tota', 'tota@gmail.com', 'pbkdf2:sha256:600000$jZaKVv3WPLhf03WC$083f65efe9e1136b0f04647da81edcb0bab6bb237d4a53d25cd389d9fd43b6ce', 'C'),
(4, 'nana', 'nana@pendeja.boba', 'pbkdf2:sha256:600000$PRsOmuVS581LyBgJ$875dd59aff3f3eafff58ac977cf65710def23545577b585cf9aa2d8c8a810d4c', 'C');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`idcomentario`);

--
-- Indices de la tabla `galera`
--
ALTER TABLE `galera`
  ADD PRIMARY KEY (`IdIMG`);

--
-- Indices de la tabla `gpersonal`
--
ALTER TABLE `gpersonal`
  ADD PRIMARY KEY (`NumIMG`),
  ADD UNIQUE KEY `NumIMG` (`NumIMG`,`idususario`),
  ADD KEY `idIMG` (`idususario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `idcomentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `galera`
--
ALTER TABLE `galera`
  MODIFY `IdIMG` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `gpersonal`
--
ALTER TABLE `gpersonal`
  MODIFY `NumIMG` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`idcomentario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `gpersonal`
--
ALTER TABLE `gpersonal`
  ADD CONSTRAINT `gpersonal_ibfk_1` FOREIGN KEY (`idususario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
