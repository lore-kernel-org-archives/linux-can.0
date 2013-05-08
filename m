From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: FYI: feature request for Qt's support for SocketCAN
Date: Wed, 8 May 2013 14:05:55 +0200
Message-ID: <201305081405.55530.pisa@cmp.felk.cvut.cz>
References: <CAGm1_kvp5v8Zh2JVzYx5onTMfTC6Z2qs0eN6744VcwBK9kpmrQ@mail.gmail.com> <201305081322.54162.pisa@cmp.felk.cvut.cz> <CAGm1_kufhXUa6c3HD=y6axzzjd7zRT=XAYnyuCc7427r+_cRhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:18264 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab3EHMGP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 08:06:15 -0400
In-Reply-To: <CAGm1_kufhXUa6c3HD=y6axzzjd7zRT=XAYnyuCc7427r+_cRhg@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Fanda Vacek <fanda.vacek@volny.cz>

On Wednesday 08 May 2013 13:52:35 Yegor Yefremov wrote:
> Dear Pavel,
> > I am not sure if some of our effort can be reused,
> > but we have implemented QT based CAN/CANopen monitor
> > and test tool during more university thesis and semester
> > works projects.
> >
> > It is part of the OrtCAN repository.
> >
> > http://ortcan.sourceforge.net/qcanalyzer/
> > If you find reply usesfull, please, place it as the follow up
> > in the RFE.
>
> Will do. Do you have some students willing to implement this as their
> Bachelor/Master Thesis?
>
> I found this thread from 2009:
> http://www.qtforum.de/forum/viewtopic.php?t=8852 in German. It seems,
> that many devs are wanting such functionality.

We are offering improvements of our CAN stuff as diploma thesis.
But it is run for the long track. I am not sure if find resources
to try that as paid student summer work or some other way to
ensure faster implementation.

I am leaving till end of week now would check the options next week.

Anyway, the most important is decision about API.

Our approach is the system of the filters based on CAN IDs
and delivery through signal slots. We should think about CAN FD
copatibility for future as well.

Best wishes,

            Pavel
