From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] can: add ability to allocate CANFD frame in skb data
Date: Wed, 15 Jan 2014 14:13:46 +0100
Message-ID: <52D6898A.9090001@peak-system.com>
References: <1389775813-14838-1-git-send-email-s.grosjean@peak-system.com>
 <52D68606.1050103@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:42967 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaAONOG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Jan 2014 08:14:06 -0500
In-Reply-To: <52D68606.1050103@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Marc,

Yes we (PEAK-System) have got onereal CANFD hardware.

Stephane

Le 15/01/2014 13:58, Marc Kleine-Budde a =C3=A9crit :
> On 01/15/2014 09:50 AM, Stephane Grosjean wrote:
>> This patch adds the ability of allocating a CANFD frame data structu=
re in the
>> skb data area.
> Do you have real CANFD hardware?
>
> Marc
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
