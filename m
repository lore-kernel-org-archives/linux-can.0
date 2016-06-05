From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: Still looking for standard low cost CAN datalogger with >= 2x CAN
 channel
Date: Sun, 5 Jun 2016 23:20:11 +0200
Message-ID: <zarafa.5754978b.40be.4b975893491651b0@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:36990 "EHLO
	euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbcFEV3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Jun 2016 17:29:22 -0400
Received: from euve35974.vserver.de (localhost.localdomain [127.0.0.1])
	by euve35974.vserver.de (Postfix) with ESMTP id 495E27580C77
	for <linux-can@vger.kernel.org>; Sun,  5 Jun 2016 23:20:11 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>

Hello,

I'm starting with a Raspi B+, a MCP2515 CAN controller connected via SPI few years ago to get more experience with embedded Linux devices and socketcan. While connecting a second MCP2515 via SPI on the Raspi B+ I and of course some other people observed some issues with higher busload (= message lost or hanging CAN-interfaces).
Martin Sperl and the introduction of DMA mode for the Raspi based architecture (BCM2708/BCM2835) did a big improvement on getting higher busload. For me round about <=20% 2014 with a Raspi B+ (Kernel 3.8.x) and >=50% with Raspi 3 (Kernel 4.4.x) for two CAN channel in parallel with candump.

What are your experience with different embedded Linux devices using socketcan?
Which are your recommendation for a low cost full featured (max busload) embedded Linux CAN datalogger?

My personal favourite is still the BeagleBone Black as the AM335x SOC has two CAN transceiver included and the CPU load is close to 1% if I'm using candump or cangw with a CAN busload >=70% (no message lost, no CAN interface crashes, no CAN interface reinit).

Regards
Michael
