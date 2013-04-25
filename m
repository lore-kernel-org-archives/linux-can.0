From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Re: Evaluating the c_can driver for EG20T
Date: Thu, 25 Apr 2013 10:55:07 +0200
Message-ID: <20130425085507.3EE222B1334F5@bmail03.one.com>
References: <20130425074353.D0711D8071390@bmail03.one.com>
 <5178E0BD.30501@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:39721 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab3DYIzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 04:55:08 -0400
Content-Disposition: inline
In-Reply-To: <5178E0BD.30501@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


<> Hi Wolfgang,

<>< Hi Jeroen,
<><> Hi Wolfgang,

<><> I think I have a patch for the "Loosing CAN messages problem"
<><> See at the bottom Appendix 7 Sugested patch.
<><> I realize that this patch has a performance penalty, but I didn't dare
<><> to make more rigorous changes.
<><> I've put the patch on top of Patch 1, of the patches that you sugested (see
<><> text below)

<><> I'm interested in all feedback.
<>< Well, we want to get rid of the pch_can driver sooner than later.
<>< Therefore I would appreciate if you could test and improve the c_can
<>< driver instead.
<>< Wolfgang.

<> I tried once before but I did not succeed. I probably did something
<> wrong. Can you tell me how I can replace the pch_can driver by the
<> c_can driver?
<> We have reduced confidence in the pch_can driver and therefor we
<> are also intrested in evaluating the c_can driver.

< Good, anyway, could you sent me your patches pch_can.c to understand
< better your lates problems.

<> Note, after applying patch 1/7 to the pch_can driver, I also
<> attemped to
<> apply the patches 2/7-7/7 which mainly/only(?) effect the c_can
<> driver.
<> 1/7 went succesfull, 2/7-7/7 not. Do I still need to apply those
<> patches?

< What exact kernel disto and kernel version are you using. With that
< knowledge I could provid new patches.
< Wolfgang.

Hi Wolfgang,

I've included the patch in the E-mail: 
"Losing CAN messages with socket-CAN" of 24 apr 2013 11:11. (Appendix 7)
It also contains kernel disto and kernel version and also
the problem description.

You replied to above mentioned E-mail: 
"Therefore I would appreciate if you could test and improve the c_can
driver instead."

Can you please indicate how to activate the c_can driver 
(instead of the pch_driver)?

Best regards,

Jeroen
