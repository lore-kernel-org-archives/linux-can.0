From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Wed, 01 Feb 2012 17:19:56 +0100
Message-ID: <4F29662C.3050509@grandegger.com>
References: <1328108253-25848-1-git-send-email-s.grosjean@peak-system.com> <4F295865.2040304@pengutronix.de> <4F295B76.8070600@grandegger.com> <4F296291.1040501@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:39328 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab2BAQT6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:19:58 -0500
In-Reply-To: <4F296291.1040501@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 02/01/2012 05:04 PM, Stephane Grosjean wrote:
>=20
> Le 01/02/2012 16:34, Wolfgang Grandegger a =E9crit :
>> I also find the name peak_pciec_init() misleading. I think
>> s/peak_pciec/peak_pciec_led/ would be more appropriate.=20
>=20
> This means "init of the 'struct peak_pciec_card' object', Moreover,
> already have a peak_pciec_init_leds()  function in the code, with whi=
ch
> one could confuse.

What does peak_pciec_init() then do apart from initializing led support=
?
The card also works without, right? Anyway, it's a minor issue.

Wolfgang.


