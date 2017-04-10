From: Markus Marb <markus@marb.org>
Subject: Re: [PATCH] can: ifi: use correct register to read rx status
Date: Mon, 10 Apr 2017 22:07:33 +0200
Message-ID: <20170410200733.GA5101@noone-desktop>
References: <e4cba95c-0a88-03cb-3e10-e49bb06b18ee@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:50557 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbdDJUHk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Apr 2017 16:07:40 -0400
Content-Disposition: inline
In-Reply-To: <e4cba95c-0a88-03cb-3e10-e49bb06b18ee@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-can@vger.kernel.org

Hi,

> Which version of the core do you use ? Can you also share value of
> register 0x54 and 0x58 ?
I am using core version 0x020F5B14 (register 0x54).
Register 0x58 is fixed i guess ? It holds 0xD073CAFD.

Regards,
Markus Marb
