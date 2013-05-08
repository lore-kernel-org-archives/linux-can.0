From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: FYI: feature request for Qt's support for SocketCAN
Date: Wed, 8 May 2013 13:22:53 +0200
Message-ID: <201305081322.54162.pisa@cmp.felk.cvut.cz>
References: <CAGm1_kvp5v8Zh2JVzYx5onTMfTC6Z2qs0eN6744VcwBK9kpmrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:29430 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab3EHL4b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 07:56:31 -0400
In-Reply-To: <CAGm1_kvp5v8Zh2JVzYx5onTMfTC6Z2qs0eN6744VcwBK9kpmrQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Fanda Vacek <fanda.vacek@volny.cz>

Dear Yegor,

On Wednesday 08 May 2013 12:24:55 Yegor Yefremov wrote:
> Here the ticket:
>
> https://bugreports.qt-project.org/browse/QTBUG-31058

I am not sure if some of our effort can be reused,
but we have implemented QT based CAN/CANopen monitor
and test tool during more university thesis and semester
works projects.

It is part of the OrtCAN repository.

http://ortcan.sourceforge.net/qcanalyzer/

QCANanalyzer provides infrastructure which can receive
and send CAN messages over SocketCAN and LinCAN drivers API
or remote connection to the CAN interface equipped target over
TCP/IP is possible. The later version can connect even to the
CANopen access provider (CANblaster in our case) which
can access CANopen object dictionary again through both
SockedCAN and LinCAN interfaces.

The solution is not perfect (yet) but quite significant time
has been laid to build basic infrastructure.

If you find reply usesfull, please, place it as the follow up
in the RFE.

Best wishes,

                Pavel Pisa
    e-mail:     pisa@cmp.felk.cvut.cz
    www:        http://cmp.felk.cvut.cz/~pisa
    university: http://dce.fel.cvut.cz/
    company:    http://www.pikron.com/
