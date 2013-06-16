From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Sun, 16 Jun 2013 10:18:48 +0200
Message-ID: <zarafa.51bd74e8.76a4.36c61f7d6f480f71@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:35800 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab3FPISx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Jun 2013 04:18:53 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Oliver_Hartkopp?= <socketcan@hartkopp.net>
Cc: =?utf-8?Q?linux-can_Mailing_List?= <linux-can@vger.kernel.org>

Hello Oliver,

> > Thnak you for pointing me to the interestin toolchain with .kcd files 
> (CANbabel translator), socketcand and Kayak.
> > Nevertheless I did some tests last weekend on my BeagleBone Black setup with 
> DCAN0/DCAN1.
> > 
> > If I fire round about 37%@500kbit/s to DCAN0 I get a tast load of round about 
> 45% of socketcand. In general it's possible for me to use Kayak on i.e. my 
> Windows machine and connect to my BeagleBone Black via ethernet. But if I use 
> the second CAN channel (DCAN1) or increase the busload of channel one (DCAN0) 
> the taskload/CPUload increases unacceptable.
> > 
> > Did you have the same experience with socketcand and Kayak?
> 
> Usually we use it with localhost IP communication.
> An in the rare cases we use a MPC5200@400MHz based embedded system with two
> CAN interfaces without any problems so far.
Can you explain your setup more in detail?
I did several tests in the last days with:
a) Kayak installed on the BeagleBone Black and export display to my Windows machine (using socketcand only on localhost)
b) Kayak installed on my windows machine and connection via ethernet port of the BeagleBone Black via socketcand

Results for a) are that the socketcand process uses round abput 45% CPU (1GHz SoC) load at 37%@500kbit/s busload and a further socketcand process for DCAN1 increases the busload depending on the busload.
 
Results for b) are unacceptable due to very low speed of the exported Kayak application via MobaXterm.

Further nice tools are:
Webbased CANlogger using socketcan 
https://bitbucket.org/Mongo/ewecan/overview

Qcanobserver - CAN sniffer Qt based
http://qcanobserver.sourceforge.net/

As I'm fighting with getting my MCP2515 to work on a BeagleBone Black (Angstrom 2013-06-06 distribution)I'm very interested in getting a guideline/howto to get it working. 
Does someone in the mailinglist have a working MCP2515 running with BeagleBone / BeagleBone Black.

Regards
Mike
