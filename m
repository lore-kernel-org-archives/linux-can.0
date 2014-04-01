From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: PCH_CAN - echo_skb is occupied
Date: Tue, 01 Apr 2014 21:29:15 +0200
Message-ID: <533B138B.1010904@grandegger.com>
References: <CA+vJB=yJ_tF1UwdwpLMVVYMKpTCQCYhWdFGGQNQNn2iP=1V3-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46620 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbaDAT3S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 15:29:18 -0400
In-Reply-To: <CA+vJB=yJ_tF1UwdwpLMVVYMKpTCQCYhWdFGGQNQNn2iP=1V3-A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: jprodriguez@elecnor.com, linux-can@vger.kernel.org

On 03/31/2014 11:59 AM, JUAN PEDRO RODRIGUEZ NIETO wrote:
> I am using a Q7 module with Atom processor and EG20T. I am using the
> latest Yocto Dora 10.0.0 to build the embedded linux image. This image
> is still using pch_can.c driver, with the "echo_skb is occupied"
> problem.
> 
> I have checked with your post
> http://marc.info/?l=linux-can&m=137180949810229&w=2
> and the source code of pch_can does not have your patch applied.
> 
> I am not familiar with kernel patching. Could you please direct me
> where can I find the latest pch_can and how to download your patch in
> patch file format so I can apply it to my poky build?
> 
> Is there any plan to release these patches in the master branch?

The EG20T does have a C_CAN core and therefore we would like to switch
to the more advanced C_CAN driver (and get rid of the pch_can driver
sooner than later). It also has less known issues. Last year I posted a
PCH PCI interface driver for the EG20T but it did not make it into
mainline yet. The problem is that I don't have any C_CAN hardware at
hand to validate the patches myself. I'm going to dig the patches out,
end of the week, also for the pch_can.

BTW, what kernel version are you using? Any chance to switch to a recent
mainline kernel?

Wolfgang.
