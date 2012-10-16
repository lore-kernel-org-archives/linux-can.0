From: Amit <amitvi128@gmail.com>
Subject: Re: [PATCH v4 2/3] can: =?utf-8?b?Y19jYW46?= Add device tree support to Bosch =?utf-8?b?Q19DQU4vRF9DQU4=?= controller
Date: Tue, 16 Oct 2012 06:17:11 +0000 (UTC)
Message-ID: <loom.20121016T081312-440@post.gmane.org>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com> <1343913191-14722-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:48018 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab2JPGUB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 16 Oct 2012 02:20:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TO0VX-00014x-M3
	for linux-can@vger.kernel.org; Tue, 16 Oct 2012 08:20:03 +0200
Received: from ns10.dnsmadeeasy.com ([208.94.148.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 16 Oct 2012 08:20:03 +0200
Received: from amitvi128 by ns10.dnsmadeeasy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 16 Oct 2012 08:20:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dear Anil,

AnilKumar Ch <anilkumar <at> ti.com> writes:

> 
> Add device tree support to C_CAN/D_CAN controller and usage details
> are added to device tree documentation. Driver was tested on AM335x
> EVM.
> 
> Signed-off-by: AnilKumar Ch <anilkumar <at> ti.com>

Did you test this on any system where CAN registers are 32 bit aligned?
I couldn't find a way to pass the "flags" option thro' DT and the first look at 
the OF DT code suggests me that there's no way to pass it.

What do you think?

Regards
Amit Virdi

