From: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Subject: Evaluating the c_can driver for EG20T
Date: Thu, 25 Apr 2013 09:43:53 +0200
Message-ID: <20130425074353.D0711D8071390@bmail03.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webmail-out2.one.com ([91.198.169.17]:33581 "EHLO
	webmail-out2.b-one.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab3DYHnz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 03:43:55 -0400
Received: from bmail03.one.com (bmail03.one.com [91.198.169.244])
	by webmail-out2.b-one.net (Postfix) with ESMTP id D306C41BF0
	for <linux-can@vger.kernel.org>; Thu, 25 Apr 2013 09:43:53 +0200 (CEST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Hi Wolfgang,
=A0
< Hi Jeroen,
<> On 04/24/2013 11:11 AM, j.p.lammertink wrote:
<> Hi Wolfgang,
=A0
<> I think I have a patch for the "Loosing CAN messages problem"
<> See at the bottom Appendix 7 Sugested patch.
<> I realize that this patch has a performance penalty, but I didn't da=
re
<> to make more rigorous changes.
<> I've put the patch on top of Patch 1, of the patches that you sugest=
ed (see
<> text below)
=A0
<> I'm interested in all feedback.
< Well, we want to get rid of the pch_can driver sooner than later.
< Therefore I would appreciate if you could test and improve the c_can
< driver instead.
< Wolfgang.

I tried once before but I did not succeed. I probably did something
wrong. Can you tell me how I can replace the pch_can driver by the=20
c_can driver?
We have reduced confidence in the pch_can driver and therefor we
are also intrested in evaluating the c_can driver.
=20
Note, after applying patch 1/7 to the pch_can driver, I also attemped t=
o
apply the patches 2/7-7/7 which mainly/only(?) effect the c_can driver.
1/7 went succesfull, 2/7-7/7 not. Do I still need to apply those patche=
s?
=20
Best regards,
=20
Jeroen
=20
