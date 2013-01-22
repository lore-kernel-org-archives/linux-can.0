From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: exclusive access to can interface
Date: Tue, 22 Jan 2013 13:53:22 +0100
Message-ID: <A2134122-6A5B-47CA-AB32-827CECA201B0@eia.be>
References: <2412937.XVpYjfC7zz@ws-stein> <50EB10F4.6070308@pengutronix.de> <3261122.aWhS3clJQh@ws-stein>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:63821 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751951Ab3AVMxk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 22 Jan 2013 07:53:40 -0500
In-Reply-To: <3261122.aWhS3clJQh@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 22 Jan 2013, at 10:41, Alexander Stein <alexander.stein@systec-electronic.com> wrote:

> Hello again,
> 
> On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
>> On 01/07/2013 05:52 PM, Alexander Stein wrote:
>>> is there a way to get exclusive (write) access to a CAN interface, so
>>> that only one bound socket can write CAN frames on the bus?
>> 
>> No, what's the use case?
> 
> I have now a more detailed view about the customers request and background: The problem runs some (time consuming) tests using CAN and they want to prohibit CAN write access meanwhile in order to prevent e.g. some (mis-)configuration of CAN devices or firmware updates. In such a case the test might shutdown and needs to be
exclusive access could be used to prevent possible race conditions, not to solve configuration of the local software.
 
> restarted. During the test nobody alse should be allowed to write to the CAN bus. I think this is justified.
"Nobody should write to the CAN bus" != "Nobody should be allowed to write to the CAN bus"

The exclusive access is only enforce on the local system. Other participants on the CAN bus
still are able to write to the CAN bus.
Your problem won't be solved.

> It seems this is unrelated to CANopen or user application started twice, like I've expected and written before.
> 
> Best regards,
> Alexander
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

