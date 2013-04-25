From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Evaluating the c_can driver for EG20T
Date: Thu, 25 Apr 2013 09:52:29 +0200
Message-ID: <5178E0BD.30501@grandegger.com>
References: <20130425074353.D0711D8071390@bmail03.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54858 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756352Ab3DYHwb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 03:52:31 -0400
In-Reply-To: <20130425074353.D0711D8071390@bmail03.one.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Cc: linux-can@vger.kernel.org

On 04/25/2013 09:43 AM, j.p.lammertink wrote:
> 
> Hi Wolfgang,
>  
> < Hi Jeroen,
> <> On 04/24/2013 11:11 AM, j.p.lammertink wrote:
> <> Hi Wolfgang,
>  
> <> I think I have a patch for the "Loosing CAN messages problem"
> <> See at the bottom Appendix 7 Sugested patch.
> <> I realize that this patch has a performance penalty, but I didn't dare
> <> to make more rigorous changes.
> <> I've put the patch on top of Patch 1, of the patches that you sugested (see
> <> text below)
>  
> <> I'm interested in all feedback.
> < Well, we want to get rid of the pch_can driver sooner than later.
> < Therefore I would appreciate if you could test and improve the c_can
> < driver instead.
> < Wolfgang.
> 
> I tried once before but I did not succeed. I probably did something
> wrong. Can you tell me how I can replace the pch_can driver by the 
> c_can driver?
> We have reduced confidence in the pch_can driver and therefor we
> are also intrested in evaluating the c_can driver.

Good, anyway, could you sent me your patches pch_can.c to understand
better your lates problems.

> Note, after applying patch 1/7 to the pch_can driver, I also attemped to
> apply the patches 2/7-7/7 which mainly/only(?) effect the c_can driver.
> 1/7 went succesfull, 2/7-7/7 not. Do I still need to apply those patches?

What exact kernel disto and kernel version are you using. With that
knowledge I could provid new patches.

Wolfgang.

