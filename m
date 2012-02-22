From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 0/3 v5] can/usb: Add PEAK-System PCAN USB adapters driver
Date: Wed, 22 Feb 2012 17:33:19 +0100
Message-ID: <4F4518CF.6070207@peak-system.com>
References: <1329481458-2586-1-git-send-email-s.grosjean@peak-system.com>
 <4F44939D.9050703@hartkopp.net> <4F44998B.3040302@hartkopp.net>
 <4F450777.3010301@peak-system.com> <4F451161.3020803@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:55344 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2BVQd1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 11:33:27 -0500
In-Reply-To: <4F451161.3020803@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 22/02/2012 17:01, Oliver Hartkopp a =E9crit :

> Pls try the following:
>
> PC1:
> can0 ->  usb-pro ch1 ----+
> can1 ->  usb-pro ch2 -+  |
> can2 ->  usb ---------+  |
>                       |  | 1Mpbs
> PC2:                 |  |
> can0 ->  pcmcia ch1 --+  |
> can1 ->  pcmcia ch2 -----+
>
> PC1:
> cangen -g0 -i can0
> cangen -g0 -i can1
> candump any
>
> PC2:
> cangen -g0 -i can0
> cangen -g0 -i can1
> candump any
>
> and then pull the usb-pro from PC1 ...
>
> That's really unfriendly 8-)


Ok, I found another cable and set up your tesbed: now the usb-pro is=20
pulled and both "candump" always are displaying data sent by "cangen=20
can0" from PC2 and read from pcan-usb on PC1... Both drivers can be=20
removed without any problem.


>
> Please check this use-case above. And when it works with your fixed d=
river you
> can probalby check the 'old' v5 version to see if you can follow my b=
ug report
> on your setup.

???
I'm sorry I don't understand what you mean: why should I check the v5=20
version? And what is (to) "follow your bug report on my setup" ???

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
