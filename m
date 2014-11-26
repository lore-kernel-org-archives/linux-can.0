From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 4/4] can: flexcan: Consolidate and unify state change  handling
Date: Wed, 26 Nov 2014 12:28:56 +0100
Message-ID: <de32a99c9a0019ee3111877947a898c6@grandegger.com>
References: <59767b14-4cc1-43e4-b4e9-32620c1d0118@GRBSR0089.marel.net>
 <5474EE9C.7030605@grandegger.com> <20141126110649.715.31413@shannon>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:39265 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaKZL26 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 26 Nov 2014 06:28:58 -0500
In-Reply-To: <20141126110649.715.31413@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

On Wed, 26 Nov 2014 11:06:49 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> Quoting Wolfgang Grandegger (2014-11-25 21:03:24)
>> On 09/26/2014 07:31 PM, Andri Yngvason wrote:
>> > Replacing error state change handling with the new mechanism.
>> > 
>> > Changes made since last proposal:
>> > can: flexcan: improve rx/tx state recognition.
>> 
>> Move below "---", please.
>> 
>> > Note: Flexcan is problematic because there is no interrupt generated
>> > when
>> > transitioning between error-active and error-passive. If the bus is
>> > disconnected, there is no event that will trigger a napi poll, so the
>> > new state
>> > will not be discovered until the bus is connected. This problem goes
>> > away if
>> > berr-reporting is enabled, because then the ack-error takes care of
it.
>> 
>> Well, this is a known issue and should be addressed via platform data
>> (using the FLEXCAN_HAS_BROKEN_ERR_STATE flags).
>>
> I thought that was about something else.
>> 
>> > 
>> > Another problem is that if nothing is happening on the bus, when it's
>> > connected
>> > again, we won't see the new state until someone transmits something
on
>> > the bus.
>> > 
>> > I'd say that these are minor issues because a "healthy" bus has
>> > traffic and the
>> > "disconnected bus" issue has a work-around.
>> 
>> Would be nice to do some tests on a more recent Flexcan core as well.
>> 
> Isn't imx6 fairly recent?

Yes it is and I'm surprised (puzzled) that it shows that behaviour.
Anyway,
just hack the driver using FLEXCAN_HAS_BROKEN_ERR_STATE to see if it
helps.

Wolfgang.
