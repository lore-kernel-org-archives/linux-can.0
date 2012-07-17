From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Xenomai] RTDM driver for the Advantech 1680U CANbus Adapter
Date: Tue, 17 Jul 2012 10:39:03 +0200
Message-ID: <500524A7.3070907@grandegger.com>
References: <4FED4948.8080906@basystemes.fr> <4FED4B42.6000808@wanadoo.fr> <4FEDF65A.50401@grandegger.com> <1012208988.15650.1341343674156.JavaMail.www@wwinf1m30> <4FF3562B.7020902@grandegger.com> <50042E37.8040205@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:58126 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab2GQIjI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Jul 2012 04:39:08 -0400
In-Reply-To: <50042E37.8040205@wanadoo.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org, Linux-CAN <linux-can@vger.kernel.org>

Hi Thierry,

thanks for your cleanup...

On 07/16/2012 05:07 PM, Thierry Bultel wrote:
> Hi Wolfgang,
> 
> How are you ?
> 
> I have taken some time, to take (almost) all your remarks into account
> about my candidate patch.
> Please see below, the new version, inline.

Unfortunately, the patch is white space mangled. Please use
git-send-email or tune your mail client not to break lines, etc.

> - code style / checkpatch : all ERRORs fixed, it remains a spurious "80
> lines" WARNING that I do not agree with.

I think the preferred coding style for Xenomai nowadays is the Linux
one. Therefore please use *tabs*" for indention (even if old RTCAN code
doesn't). This should also make checkpatch.pl even more happier.

> - multiple devices: The driver now (theoretically) supports as many
> devices as its original linux version

Could you mention them in the Kconfig help? Just in case you know the
names of these devices.

> - plx highjack: fixed, this was a bug, actually.
> 
> The patch is generated vs xenomai-2.6.0, because it is my testing
> environnement. I will unfortunately and
> unlikely not have time to perform some tests with a more recent version.
> I hope this is not a blocking issue and that you will be able to
> integrate it anyway.

Should not be a real problem.

> Another topic, please, I would like to know if you have an estimate date
> for the availability of the RTDM
> drivers for Flexcan, and the IMX6 serial as well ?

As you might have realized, there is some interest on a RTCAN Flexcan
driver, which I'm currently working on. Hope to have something ready
this or next week. The same for publishing my rt_imx_uart driver.

Wolfgang.
