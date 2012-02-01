From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Wed, 01 Feb 2012 17:12:13 +0100
Message-ID: <4F29645D.2090606@peak-system.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com>
 <4F295865.2040304@pengutronix.de> <4F295EB8.3090202@pengutronix.de>
 <4F296068.9090009@peak-system.com> <4F2960EF.6000308@pengutronix.de>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:47966 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab2BAQMW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:12:22 -0500
In-Reply-To: <4F2960EF.6000308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 01/02/2012 16:57, Marc Kleine-Budde a =E9crit :
> On 02/01/2012 04:55 PM, Stephane Grosjean wrote:
>> What about that:
>>> #if defined(CONFIG_I2C_ALGOBIT) || defined(CONFIG_I2C_ALGOBIT_MODUL=
E)
>>> #define peak_pci_support_pcie()    (1)
>>> #else
>>> #define peak_pci_support_pcie()    (0)
>> #define i2_transfer(a, b, c)
>> #define i2c_del_adapter(a)
>>> #endif
> This is an option, please make it static inline function, to have
> typechecking.
>

static inline'd functions not possible while I unconditionally keep the=
=20
#include <linux/i2c.h>

So, what?

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
