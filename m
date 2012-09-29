From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] flexcan: disable bus error interrupts for the i.MX28
Date: Sat, 29 Sep 2012 14:00:05 +0800
Message-ID: <50668E65.8030500@gmail.com>
References: <5065A35B.3020702@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57278 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754951Ab2I2GA0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 29 Sep 2012 02:00:26 -0400
In-Reply-To: <5065A35B.3020702@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux Netdev List <netdev@vger.kernel.org>, Linux-CAN <linux-can@vger.kernel.org>, Hui Wang <jason77.wang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

Wolfgang Grandegger wrote:
> Due to a bug in most Flexcan cores, the bus error interrupt needs
> to be enabled. Otherwise we don't get any error warning or passive
> interrupts. This is _not_ necessay for the i.MX28 and this patch
>   
s/necessay/necessary/


Other looks fine to me.  Reviewed-by:  Hui Wang <jason77.wang@gmail.com>
