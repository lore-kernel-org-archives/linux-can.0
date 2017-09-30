From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Implement new Kvaser USB driver, where to start?
Date: Sat, 30 Sep 2017 22:50:40 +0200
Message-ID: <a948f73e-f80a-98f0-b385-09c75eb6c00a@hartkopp.net>
References: <4a46b81e-1073-8a33-e674-d43c8579985a@kvaser.com>
 <76194977-f3a6-25ab-59c3-b8c66f0a35e3@hartkopp.net>
 <24381ef3-9179-7f39-e1bf-1a75c6063e69@kvaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:14722 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbdI3UvD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 30 Sep 2017 16:51:03 -0400
In-Reply-To: <24381ef3-9179-7f39-e1bf-1a75c6063e69@kvaser.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org

Hi Jimmy,

On 09/29/2017 11:26 AM, Jimmy Assarsson wrote:

> 'Slightly' different is an understatement ;-) The overall concept is the same,
> and most of the 'command numbers' match. However, the message structure is
> different. So the message handling/decoding is platform dependent.

(..)

> It does. Similar to what PEAK have done. I bet we will have some refactoring
> work ahead of us. 

Yes. I assume a wise refactoring will reveal the best way to go automatically.
E.g. share 'command numbers' but handle different data structures based on the
specific product.

> How can we test that we do not break anything? I've found
> some tests here https://github.com/linux-can/can-tests are there any other
> tests that we should be aware of? Which of the tests makes sense for us to run?

The can-tests are mostly for the stuff in the network layer (linux/net/can)
and not the drivers (linux/drivers/net/can).

There are different things to be tested:

1. check whether all possible types & contents of CAN frames are sent/received
correctly

2. run load tests (e.g. with cangen or canfdtest from can-utils) and check the
completeness and behaviour when the interfaces are detached in unfriendly ways
(USB plug-out under load).

3. check the behaviour and error message generation under BUS-OFF and error
conditions that are caused by CAN defects (bus short-cut, wrong bitrates,
unterminates bus, no second CAN node, etc).

That's the way I did the testing of new CAN hardware & drivers so far.
Maybe not a complete guidline ;-)

Best regards,
Oliver
