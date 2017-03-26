From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] can: ifi: use correct register to read rx status
Date: Sun, 26 Mar 2017 17:06:01 +0200
Message-ID: <e4cba95c-0a88-03cb-3e10-e49bb06b18ee@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:56310 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdCZPHa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Mar 2017 11:07:30 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Markus Marb <markus@marb.org>

Hi,

I was notified about this patch recently, unfortunately I was not on CC
on the original submission, so I was unable to review/test this patch.
Nice catch though, thanks.

Which version of the core do you use ? Can you also share value of
register 0x54 and 0x58 ?

Thanks
-- 
Best regards,
Marek Vasut
