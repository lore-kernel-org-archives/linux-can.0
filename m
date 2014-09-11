From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: Inconsistent error state transition error frames
Date: Thu, 11 Sep 2014 10:03:12 +0000
Message-ID: <54117360.2060004@marel.com>
References: <7EAA3DE6DC6BA14D830C95541CC66EBC9F72FED6@GRBSR0004.marel.net>
 <540DDB16.8010304@pengutronix.de>
 <a62de8d447dda55b1aa30711f0dc4605@grandegger.com>
 <540EEBA0.9080209@marel.com>
 <56f33e0559ffda649925492dca2720fd@grandegger.com>
 <540F1396.2030702@marel.com>
 <1a51435a44c2ebd32cca3feee3799af3@grandegger.com>
 <540F4225.4090907@hartkopp.net> <541025B5.9070901@marel.com>
 <54102803.4070404@pengutronix.de>
 <25bf289f701148cd1800c8e79da342aa@grandegger.com>
 <5410A1A5.1090802@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [157.56.110.87] ([157.56.110.87]:39648 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754302AbaIKLjo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 11 Sep 2014 07:39:44 -0400
In-Reply-To: <5410A1A5.1090802@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org


On mi=C3=B0 10.sep 2014 19:08, Oliver Hartkopp wrote:
>
>> I'm not sure... we also need to set the value. Therefore I would
>> vote for:
>>
>>   frame->data[CAN_ERR_TXERR_BYTE];
>>
>> It does make the code more readable.
> Unfortunately CAN_ERR_TXERR_BYTE is pretty long and I have no good id=
ea
> how to make it shorter. CAN_ERR_TXERR_IDX is probably more handy.
>
> E.g.
>
> 	frame->data[CAN_ERR_CTRL_IDX] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
>
> I would vote for something like this too.
>
> Should I send a patch for this approach?
Don't most people have auto-completion in their editors nowadays?=20
Anyway, I'd been thinking about suggesting 'INDEX' rather than 'BYTE'=20
because it really is a more descriptive name, so I'm happy with 'IDX'.=20
'BYTE' can mean other things while 'IDX' is pretty clear.

Andri
