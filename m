From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 + iMX6 + yocto
Date: Fri, 11 Sep 2015 11:48:15 +0200
Message-ID: <20150911094815.GB24037@airbook.eia.lan>
References: <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be>
 <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <20150908075800.GA864@airbook.eia.lan>
 <10825_1441878970_55F153BA_10825_1523_1_e2938c8e-30db-4942-96df-1d6a7628d355@OPEXCLILM7D.corporate.adroot.infra.ftgroup>
 <20150910113419.GA13189@airbook.eia.lan>
 <2144_1441891087_55F1830F_2144_9033_1_72e71e6a-832b-4f03-b5a6-47ea4e7bb890@OPEXCLILMA3.corporate.adroot.infra.ftgroup>
 <55F185FF.3030400@pengutronix.de>
 <17840_1441899129_55F1A279_17840_5145_1_32faddc5-c842-4de6-9f1a-8ca0e47ed042@OPEXCLILMA4.corporate.adroot.infra.ftgroup>
 <20150911034936.GA23393@airbook.vandijck-laurijssen.be>
 <18444_1441953980_55F278BC_18444_4440_1_834eb28f-a47f-4f8b-9033-cc97f68e2f45@OPEXCLILM7E.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:15188 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbbIKJtj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Sep 2015 05:49:39 -0400
Content-Disposition: inline
In-Reply-To: <18444_1441953980_55F278BC_18444_4440_1_834eb28f-a47f-4f8b-9033-cc97f68e2f45@OPEXCLILM7E.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> My kernel is a part of the Yocto generation.

Because we have our own board, we never actually used the kernel from
Yocto, instead we told yocto to use our own kernel.
I've never actually performed the operation on yocto's kernel.

Can you provide the git url of the kernel you were using (that
v3.10-r0)?
I could give it a try to merge can-j1939 into it.

> In fact, I tried to patch the <yocto>/tmp/work/git/ repository because the kernel is here.
> Perhaps, it was a bad idea. What do you think about that?

As told above, we tell yocto to use a different kernel, because I think
that is easier.

Of course, our kernel also has a bunch of freescale commits applied.

Kurt
