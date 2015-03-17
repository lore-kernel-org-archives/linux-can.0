From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] can: add new socket option CAN_RAW_FILTER_UNIQUE
 to eliminate duplicate matches
Date: Tue, 17 Mar 2015 16:36:06 +0100
Message-ID: <550849E6.7040104@gmail.com>
References: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:33097 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbbCQPgJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 11:36:09 -0400
Received: by weop45 with SMTP id p45so10698772weo.0
        for <linux-can@vger.kernel.org>; Tue, 17 Mar 2015 08:36:08 -0700 (PDT)
In-Reply-To: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On 17.03.2015 13:58, Oliver Hartkopp wrote:
> The CAN_RAW socket can set multiple CAN identifier specific filters that lead
> to multiple filters in the af_can.c filter processing. These filters are
> indenpendent from each other which leads to logical OR'ed filters when applied.
> 
> Especially when the filter is intended to notch single CAN IDs or CAN ID ranges
> a problem emerges when using more than just one filter: The notched CAN IDs
> will be delivered once while the other CAN IDs will be delivered twice.
> 
> This patch implements a new option to make sure that every CAN frame which is
> filtered for a specific socket is only delivered once to the user space.
> This is independent from the number of matching CAN filters of this socket.

Hi Oliver.

I don't think this should be an option. A CAN-frame should never be
delivered more than once even if multiple filters match.

In my eyes this is a long standing bug ;-), which would get an
off-switch this way.

Regards
  Andre
