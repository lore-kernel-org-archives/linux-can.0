From: Stuart Statman <sstatman@sunverge.com>
Subject: Re: "Blessed" Version
Date: Mon, 15 Oct 2012 11:12:24 -0700
Message-ID: <507C5208.7050100@sunverge.com>
References: <5074B274.7070703@sunverge.com> <507554BB.4000809@grandegger.com> <5077196C.60405@sunverge.com> <50793FAD.6030704@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39643 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab2JOSMP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 15 Oct 2012 14:12:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5099599pad.19
        for <linux-can@vger.kernel.org>; Mon, 15 Oct 2012 11:12:15 -0700 (PDT)
In-Reply-To: <50793FAD.6030704@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org


On 10/13/12 3:17 AM, Oliver Hartkopp wrote:

>> 2. Is there a can_if style script that already handles slcan?
> We have extended the can_if script for slcan at Volkswagen and also extended
> the slcand to do some of the setup from slcan_attach (e.g. for the CAN
> bitrate). I don't know the exact state of these extensions and if it works
> stable in all environments (udev, ...). But if you like, i can sent it to you
> and you may check if it fit's your needs and if it's worth to merge it with
> the can-utils.
I would love to see this! Thanks!

-- 
Stu Statman
VP of Engineering
Sunverge, Inc
http://www.sunverge.com
