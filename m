From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] canutils: candump: Add error frame's handling
Date: Tue, 10 Jan 2012 15:01:02 +0100
Message-ID: <4F0C449E.4070202@grandegger.com>
References: <1326201911-18255-1-git-send-email-anilkumar@ti.com> <4F0C3FE2.9060606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51085 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787Ab2AJOBO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 09:01:14 -0500
In-Reply-To: <4F0C3FE2.9060606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: AnilKumar Ch <anilkumar@ti.com>, m.kleine-budde@pengutronix.de, r.schwebel@pengutronix.de, linux-can@vger.kernel.org, nsekhar@ti.com

On 01/10/2012 02:40 PM, Marc Kleine-Budde wrote:
> On 01/10/2012 02:25 PM, AnilKumar Ch wrote:
>> This patch adds the error handling capability to candump utility
>> by adding error flags for displaying all kind of error frames
>> like tx_timeout, lost arbitration, controller problems, buserrors,
>> bus warnings etc.
>>
>> Usage of candump for error frame display on console:
>> candump [<can-interface>] [Options]
>> Ex: candump can0 --error
>>
>> This patch is created on top of canutils-4.0.6 tag from
>> http://git.pengutronix.de/?p=tools/canutils.git
> 
> Tnx, applied

BTW: In the official can-utils, we also have the possibility to display
human readable error messages:

https://gitorious.org/linux-can/can-utils/commit/796475677af173599db655064413f0692c15df3e

Wolfgang.
