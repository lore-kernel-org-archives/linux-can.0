From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Evaluating the c_can driver for EG20T
Date: Thu, 25 Apr 2013 11:23:48 +0200
Message-ID: <5178F624.5000208@grandegger.com>
References: <20130425074353.D0711D8071390@bmail03.one.com> <5178E0BD.30501@grandegger.com> <20130425085507.3EE222B1334F5@bmail03.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35711 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab3DYJXy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 05:23:54 -0400
In-Reply-To: <20130425085507.3EE222B1334F5@bmail03.one.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Cc: linux-can@vger.kernel.org

On 04/25/2013 10:55 AM, j.p.lammertink wrote:
> 
> <> Hi Wolfgang,
> 
> <>< Hi Jeroen,
> <><> Hi Wolfgang,
> 
> <><> I think I have a patch for the "Loosing CAN messages problem"
> <><> See at the bottom Appendix 7 Sugested patch.
> <><> I realize that this patch has a performance penalty, but I didn't dare
> <><> to make more rigorous changes.
> <><> I've put the patch on top of Patch 1, of the patches that you sugested (see
> <><> text below)
> 
> <><> I'm interested in all feedback.
> <>< Well, we want to get rid of the pch_can driver sooner than later.
> <>< Therefore I would appreciate if you could test and improve the c_can
> <>< driver instead.
> <>< Wolfgang.
> 
> <> I tried once before but I did not succeed. I probably did something
> <> wrong. Can you tell me how I can replace the pch_can driver by the
> <> c_can driver?
> <> We have reduced confidence in the pch_can driver and therefor we
> <> are also intrested in evaluating the c_can driver.
> 
> < Good, anyway, could you sent me your patches pch_can.c to understand
> < better your lates problems.
> 
> <> Note, after applying patch 1/7 to the pch_can driver, I also
> <> attemped to
> <> apply the patches 2/7-7/7 which mainly/only(?) effect the c_can
> <> driver.
> <> 1/7 went succesfull, 2/7-7/7 not. Do I still need to apply those
> <> patches?
> 
> < What exact kernel disto and kernel version are you using. With that
> < knowledge I could provid new patches.
> < Wolfgang.
> 
> Hi Wolfgang,
> 
> I've included the patch in the E-mail: 
> "Losing CAN messages with socket-CAN" of 24 apr 2013 11:11. (Appendix 7)
> It also contains kernel disto and kernel version and also
> the problem description.

OK. could you send the file "pch_can.c" you used (sorry for my bad
English). Your kernel is obviously 3.5.0-27-generic from Ubuntu. I'm
going to rebase the patches on top of mainline Linux 3.5.0. Any chance
for you to use a recent mailing Linux version?

> You replied to above mentioned E-mail: 
> "Therefore I would appreciate if you could test and improve the c_can
> driver instead."
> 
> Can you please indicate how to activate the c_can driver 
> (instead of the pch_driver)?

You need to deselect the PCH_CAN and select the C_CAN PCI driver in your
kernel config. I use "make menuconfig" for that purpose. But you need
the complete patch stack.

Wolfgang.

