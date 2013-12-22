From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [can:for-davem 3/3] drivers/net/can/ti_hecc.c:909:7: warning:
 assignment makes pointer from integer without a cast
Date: Sun, 22 Dec 2013 17:35:46 +0400
Message-ID: <52B6EAB2.1050508@cogentembedded.com>
References: <52b60e29.e6MbNbPY4sH1N+Ql%fengguang.wu@intel.com> <52B60F21.5070502@pengutronix.de> <20131221225722.GA12243@localhost> <52B61E95.1050706@pengutronix.de> <20131221232157.GB12243@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57512 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab3LVNfu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Dec 2013 08:35:50 -0500
Received: by mail-lb0-f181.google.com with SMTP id q8so1819544lbi.26
        for <linux-can@vger.kernel.org>; Sun, 22 Dec 2013 05:35:48 -0800 (PST)
In-Reply-To: <20131221232157.GB12243@localhost>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello.

On 22-12-2013 3:21, Ezequiel Garcia wrote:

>>>> Should we go back to "depends on ARM"?

>>> Well, it seems user-mode linux has no ioremap? So, maybe we'll have to
>>> live with "depends on ARM" unless anyone has a better idea.

>> Then it's Patch v2.

> What puzzles me is that other drivers are doing this same COMPILE_TEST
> trick (see MTD_NAND_SH_FLCTL). I guess they just ignore the 0-day build
> error?

    Perhaps they just don't use ioremap() directly but use its devm_*() variants?

WBR, Sergei

