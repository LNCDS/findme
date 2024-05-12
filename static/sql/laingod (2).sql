-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 27-11-2023 a las 03:12:47
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
-- Estructura de tabla para la tabla `ads`
--

CREATE TABLE `ads` (
  `ads` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `fecha_subida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ruta` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ads`
--

INSERT INTO `ads` (`ads`, `nombre`, `descripcion`, `fecha_subida`, `ruta`) VALUES
(2, 'spike', '1234', '2023-11-26 18:18:49', 'img/galeria/386229659_641473511461775_656049734295095609_nBKMLK.jpg'),
(3, 'shinji', 'shinji', '2023-11-26 18:31:36', 'img/galeria/Evangelion_Shinji_Ikari_GIF_-_Evangelion_Shinji_Ikari_Shinji_-_Discover__Share_GIFsJMLNC.gif'),
(4, 'sunset', '', '2023-11-26 18:37:12', 'img/galeria/Pixel_Sunset_NMKLN.jpeg'),
(5, '', '', '2023-11-26 18:51:09', 'img/galeria/zBNLNV.jpeg');

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
  `FechaS` timestamp NULL DEFAULT NULL,
  `iduserimg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `galera`
--

INSERT INTO `galera` (`IdIMG`, `rutaimg`, `Tituloimg`, `Descripcion`, `FechaS`, `iduserimg`) VALUES
(1, 'img/galeria/descargar_1VCVSF.jpg', 'Lain payasa', ' \"Lain\" de \"Serial Experiments Lain\" es un personaje complejo y fascinante dentro del anime. Intentar representar su esencia en un estilo de pintura \"pintada de paytasa\" podría implicar la captura de su singularidad e inmersión en un estilo artístico particular.  ', '2023-11-06 03:15:19', 1),
(3, 'img/galeria/A_poco_si_muy_vergasCNSFB.jpg', 'a poco si muy verga ', 'Una imagen que me recuerda la tristeza del hombre y del alma', '2023-11-06 03:16:15', 1),
(4, 'img/galeria/descargarNSCJD.ico', 'Lain en una carpeta', 'Aqui se demuestra mi obsesión con esta personaje llamada lain, y si pueden descargarlo para ponerlo de icono en sus carpetas. ', '2023-11-06 03:18:57', 1),
(5, 'img/galeria/marcosNKDSS.jpg', 'marcos', 'marquitos mejor que adam', '2023-11-06 16:00:57', 1),
(6, 'img/galeria/susDVKND.jpg', 'Haruhi', 'que hermosa se ve', '2023-11-06 16:01:25', 1),
(7, 'img/galeria/tiger2SKSLV.jpeg', 'Tanque', 'Tanque', '2023-11-06 16:04:24', 1),
(8, 'img/galeria/The_moon_and_meDNKSS.jpeg', 'la luna y yo', 'la luna', '2023-11-10 04:04:30', 1),
(9, 'img/galeria/SpikeJSSNF.jpg', 'Spike', 'Mirame a los faey, uno de ellos es falso porque lo perdi en un accidente, desde ese momento con un ojo veo el pasado y con el otro el presente, asi que solo veo fragmentos de la realidad y nunca la imagen completa.', '2023-11-16 02:13:34', 1),
(10, 'img/galeria/Lain_duster_boaMDNSJ.jpeg', 'nose ', 'xd', '2023-11-18 03:16:37', 1),
(11, 'img/galeria/roboCLNMV.jpeg', '21', '3reefrefrrewwerwerwerwerwe', '2023-11-18 03:38:41', 1),
(12, 'img/galeria/333984285_733655161562741_7278757566464360531_nDSSVC.jpg', 'payasa', '', '2023-11-18 17:01:32', 1),
(13, 'img/galeria/330314681_3188825484673193_6586100641062293774_nSVKNN.jpg', 'laini', 'que bonita, toda tierna', '2023-11-22 02:20:49', 1),
(14, 'img/galeria/likeSLNVK.gif', 'payasa', 's', '2023-11-25 08:08:56', 1),
(15, 'img/galeria/e358bcaf-c24c-485e-ae45-b6991c55baacNDJVD.jpg', 'haruhi-tanque', 'Joder haruhi montada sobre un tiger h1', '2023-11-26 17:22:35', 1),
(22, 'img/galeria/7725000d-0c1f-4f1c-9110-838d25479f13DVNKJ.jpeg', 'payasa', 'xsxsx', '2023-11-26 17:57:19', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gpersonal`
--

CREATE TABLE `gpersonal` (
  `NumIMG` int(11) NOT NULL,
  `idususario` int(11) NOT NULL,
  `ruta` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `gpersonal`
--

INSERT INTO `gpersonal` (`NumIMG`, `idususario`, `ruta`) VALUES
(5, 11, 'img/imguser/HD_wallpaper__redheads_tengen_toppa_gurren_lagann_undressing_yoko_littner_2295x2857_Anime_Hot_Anime_HD_ArtCVSLF.jpg'),
(6, 12, 'img/imguser/susCNNBL.jpg'),
(7, 13, 'img/imguser/Lain_duster_boaKBSLL.jpeg'),
(9, 15, 'img/imguser/lightVNFDS.jpg'),
(10, 2, 'img/imguser/Is_Anime_Cool____-_I_drink_and_watch_animeCLDVD.jpg'),
(11, 1, 'img/imguser/descarga_4MNFCK.jpeg'),
(12, 2, 'img/imguser/Is_Anime_Cool____-_I_drink_and_watch_animeCLDVD.jpg'),
(13, 1, 'img/imguser/descarga_4MNFCK.jpeg'),
(14, 16, 'img/imguser/c018f87b-eed2-4680-a86f-d9d155b3dc7dVLLDM.jpg'),
(15, 17, 'img/imguser/backgroundSKKFD.jpg'),
(16, 18, 'img/imguser/TexturasMLKNJ.jpeg');

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
(1, 'thanatos', 'pop@tu.corazon', 'pbkdf2:sha256:600000$WXyzhjmrakmRKN2b$5cc71f03f425c0eee60286b2ce26053335cc648b612007ede4c90a4e9ee56449', 'A'),
(2, 'tadeo', 'tadeofrancisco36@gmail.com', 'pbkdf2:sha256:600000$CWklnfxQqnlLVZRy$c31ebbb1b0865d83668535514722f2e05bd0e86961e819383411b2410c3387a1', 'C'),
(11, 'nagato', 'nagatoyuki@gmail.com', 'pbkdf2:sha256:600000$kYjzs85AgJZvWOcz$8099f3e130bd0276f734214f06411662a6108674687cc19b01dce09edf31e8dd', 'C'),
(12, 'haruhi', 'sos@gmail.com', 'pbkdf2:sha256:600000$KaUl9mmogRgEJ9hv$2e3c3771cc0e0090cf6eb5744e6bb0f2409ef31b721e89083a06421d7be473e6', 'C'),
(13, 'lain', 'juan.tadeo1690@alumnos.udg.mx', 'pbkdf2:sha256:600000$XhbhkCkjaJhHjYQF$e18bf5974952f7b2aeab99a43cb6a2fdde62ee5ecdfb7713b6522f03164ce3f1', 'C'),
(15, 'light', 'death@note.com', 'pbkdf2:sha256:600000$goN5UgHLIzytDfbM$4b81eb1149335b9f4e37bd8f7699ee38870a0c5a4758c4de42033e6bf95bef3a', 'C'),
(16, 'ia', 'ft2214081@gmail.com', 'pbkdf2:sha256:600000$WukurzaUUn9eoSsx$19ebaa60434d6a54f4b3c42f02c1519689990581aa691c10dcda1e5833663877', 'C'),
(17, 'defautl2', 'default@1', 'pbkdf2:sha256:600000$Ixaipjct1pEDknnO$d8d8726828ff4adfdddfe23aeeaa3e54af5f4dabf3a523bea2625e107339e9ff', 'C'),
(18, 'defautl2', 'default@2', 'pbkdf2:sha256:600000$WJ5OdOue8TtTp3Tn$9455514148bdf8525a633c0828734dc637110a2af03b0a99c275be73a25bce80', 'C');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`ads`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`idcomentario`);

--
-- Indices de la tabla `galera`
--
ALTER TABLE `galera`
  ADD PRIMARY KEY (`IdIMG`),
  ADD KEY `Iduser` (`iduserimg`) USING BTREE;

--
-- Indices de la tabla `gpersonal`
--
ALTER TABLE `gpersonal`
  ADD PRIMARY KEY (`NumIMG`),
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
-- AUTO_INCREMENT de la tabla `ads`
--
ALTER TABLE `ads`
  MODIFY `ads` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `idcomentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `galera`
--
ALTER TABLE `galera`
  MODIFY `IdIMG` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `gpersonal`
--
ALTER TABLE `gpersonal`
  MODIFY `NumIMG` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `galera`
--
ALTER TABLE `galera`
  ADD CONSTRAINT `galera_ibfk_1` FOREIGN KEY (`iduserimg`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `gpersonal`
--
ALTER TABLE `gpersonal`
  ADD CONSTRAINT `gpersonal_ibfk_1` FOREIGN KEY (`idususario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
