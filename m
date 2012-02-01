From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Wed, 01 Feb 2012 17:04:33 +0100
Message-ID: <4F296291.1040501@peak-system.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com>
 <4F295865.2040304@pengutronix.de> <4F295B76.8070600@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:46243 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab2BAQEl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:04:41 -0500
In-Reply-To: <4F295B76.8070600@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>


Le 01/02/2012 16:34, Wolfgang Grandegger a =E9crit :
> I also find the name peak_pciec_init() misleading. I think=20
> s/peak_pciec/peak_pciec_led/ would be more appropriate.=20

This means "init of the 'struct peak_pciec_card' object', Moreover,=20
already have a peak_pciec_init_leds()  function in the code, with which=
=20
one could confuse.

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
