From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Inconsistent error state transition error frames
Date: Tue, 09 Sep 2014 17:41:12 +0200
Message-ID: <1a51435a44c2ebd32cca3feee3799af3@grandegger.com>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
 <540DDB16.8010304@pengutronix.de>
 <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
 <540EEBA0.9080209@marel.com>
 <56f33e0559ffda649925492dca2720fd@grandegger.com>
 <540F1396.2030702@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:58486 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaIIPlO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 9 Sep 2014 11:41:14 -0400
In-Reply-To: <540F1396.2030702@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 9 Sep 2014 14:49:58 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> On =C3=BEri 9.sep 2014 13:53, Wolfgang Grandegger wrote:
>> On Tue, 9 Sep 2014 11:59:28 +0000, Andri Yngvason
>> <andri.yngvason@marel.com> wrote:
>>> On =C3=BEri 9.sep 2014 10:48, Wolfgang Grandegger wrote:
=2E..
>>> haven't posted patches to the kernel before, but I've read the
>>> documentation and hopefully I'll get it right. ;)
>> Don't worry. You will learn it quickly.
> Thanks for the reassurance. Which branch should I rebase against,=20
> linux-can or linux-can-next?

linux-can-next please.

=2E..
> It seems that 'data' is fully occupied, although 'data[5..7]' isn't=20
> reserved for anything specific but rather "controller specific=20
> additional information". Could we maybe put the version into data 5, =
6
or
> 7?

data[6..7] is used for the tx and rx error counts.
=20
> Another option is to place it into the 3 or 4 msb of the id; somethin=
g=20
> like this:
> #define CAN_ERR_VERSION_MASK 0x1E000000U  // Note: CAN_ERR_MASK is=20
> 0x1FFFFFFFU
>=20
> Are 15 possible versions enough (or even too much)?

I would prefer an unsued field otherwise old can-util tools will report
rubbish. data[5] sounds good. But we should add a version number only
if we really need it.

Wolfgang.

