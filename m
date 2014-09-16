From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: RFC: Improve and consolidate error state change
Date: Tue, 16 Sep 2014 16:50:12 +0200
Message-ID: <546733c3619a98acef3764d147f96876@grandegger.com>
References: <5411F360.4020103@marel.com> <54184AE0.6050100@marel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:60778 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143AbaIPOuQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 16 Sep 2014 10:50:16 -0400
In-Reply-To: <54184AE0.6050100@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, 16 Sep 2014 14:36:16 +0000, Andri Yngvason
<andri.yngvason@marel.com> wrote:
> On fim 11.sep 2014 19:09, Andri Yngvason wrote:
>> Hello,
>>
>> As we've discussed in a recent thread, error state changes are 
>> inconsistent
>> between platforms. Wolfgang had already done some work on this a 
>> couple of
>> years ago, but it never made it into the kernel.
>> See: http://thread.gmane.org/gmane.linux.can/201
> 
> ...
>>
>> I've also edited the mscan, flexcan and sja1000 drivers to use this 
>> function,
>> but I actually don't have hardware to test this on any other platforms.
>>
>> Is anyone willing to test this on other platforms?
>>
>> I'll post patches, when there's been feedback on this.
>>
> 
> Ping?

That's perfectly fine to start with.

Wolfgang.
