From: Stuart Statman <sstatman@sunverge.com>
Subject: Re: "Blessed" Version
Date: Thu, 11 Oct 2012 12:09:32 -0700
Message-ID: <5077196C.60405@sunverge.com>
References: <5074B274.7070703@sunverge.com> <507554BB.4000809@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38275 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933367Ab2JKTJe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 15:09:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2158105pbb.19
        for <linux-can@vger.kernel.org>; Thu, 11 Oct 2012 12:09:34 -0700 (PDT)
In-Reply-To: <507554BB.4000809@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org


On 10/10/12 3:58 AM, Wolfgang Grandegger wrote:
> We have moved to http://gitorious.org/linux-can. CAN utilities and 
> kernel modules have been separated. You find them under "can-utils" 
> and "can-modules". If you can, you should use a recent kernel version 
> to avoid the "can-modules". I'm afraid, they are not really well 
> maintained. What kernel version do you plan to use? What CAN hardware 
> do you want to support? 
Strangely enough, just yesterday we made a decision to migrate CAN 
hardware that reduced the urgency of my question.

However, it does bring up another question.

I've been using slcand and "ip link set xxx up" for a piece of hardware 
that uses the slcan protocol. I'm pretty happy with how it's working, 
but I'd be happier if it was compatible with the can_if script that's in 
the utilities. I could write my own version of can_if that just does the 
right things for slcan, but it does open up a few questions :

1. What is slcan anyway, and why is it not handled like the other drivers?
2. Is there a can_if style script that already handles slcan?
-- 
Stu Statman
VP of Engineering
Sunverge, Inc
http://www.sunverge.com
