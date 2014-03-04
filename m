From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v9 0/7] Add CAN FD infrastructure for CAN driver
Date: Tue, 04 Mar 2014 13:15:47 +0100
Message-ID: <5315C3F3.4090206@peak-system.com>
References: <1393601785-4631-1-git-send-email-socketcan@hartkopp.net>
 <53159B51.4020704@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:50011 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756931AbaCDMP5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 07:15:57 -0500
In-Reply-To: <53159B51.4020704@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Marc,

You did well !

St=C3=A9phane

Le 04/03/2014 10:22, Marc Kleine-Budde a =C3=A9crit :
> On 02/28/2014 04:36 PM, Oliver Hartkopp wrote:
>> This is the patch series to extend the CAN driver infrastructure wit=
h CAN FD.
>>
>> Changes v8 -> v9:
>>
>> Fixed a whitepace issue in patch 4 and added a comment about the dif=
ferent
>> configuration options.
>>
>> *** BLURB HERE ***
>>
>> Oliver Hartkopp (7):
>>    can: preserve skbuff protocol in can_put_echo_skb
>>    can: only send bitrate data via netlink when available
>>    can: move sanity check for bitrate and tq into can_get_bittiming
>>    can: provide a separate bittiming_const parameter to bittiming
>>      functions
>>    can: introduce the data bitrate configuration for CAN FD
>>    can: allow to change the device mtu for CAN FD capable devices
>>    can: add bittiming check at interface open for CAN FD
>>
>>   drivers/net/can/dev.c            | 160 +++++++++++++++++++++++++++=
+++---------
>>   include/linux/can/dev.h          |   7 +-
>>   include/uapi/linux/can/netlink.h |   3 +
>>   3 files changed, 133 insertions(+), 37 deletions(-)
> Stephane, I'll add your Acked-by that you have given for the v8 of th=
is
> series.
>
> Marc
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
