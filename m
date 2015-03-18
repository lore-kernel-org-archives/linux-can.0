From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH v2 2/2] can: introduce new raw socket option to join the
 given CAN filters
Date: Wed, 18 Mar 2015 23:47:15 +0200
Message-ID: <20150318214715.GA2602@Darwish.PC>
References: <1426659036-4628-1-git-send-email-socketcan@hartkopp.net>
 <1426659036-4628-2-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:34954 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933237AbbCRVrU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Mar 2015 17:47:20 -0400
Received: by webcq43 with SMTP id cq43so42817764web.2
        for <linux-can@vger.kernel.org>; Wed, 18 Mar 2015 14:47:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426659036-4628-2-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On Wed, Mar 18, 2015 at 07:10:35AM +0100, Oliver Hartkopp wrote:
> The CAN_RAW socket can set multiple CAN identifier specific filters that lead
> to multiple filters in the af_can.c filter processing. These filters are
> indenpendent from each other which leads to logical OR'ed filters when applied.
> 
> This socket option joines the given CAN filters in the way that only CAN frames
> are passed to user space that matched *all* given CAN filters. The semantic for
> the applied filters is therefore changed to a logical AND.
> 
> This is useful especially when the filterset is a combination of filters where
> the CAN_INV_FILTER flag is set in order to notch single CAN IDs or CAN ID
> ranges from the incoming traffic.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> 
> v2: fix first reception of joint filter CAN frame
> 

I've done some very basic smoke tests on 4.0.0-rc4+, and
everything seems to work just as it says on the tin :-)

Before applying the two kernel patches:

$ cangen vcan0 -Di -Ii -L4 &

$ candump vcan0,0:0,0:0,0:0

  /* 3 filters, 3 times repeat for each frame */
  vcan0  000   [4]  00 00 00 00
  vcan0  000   [4]  00 00 00 00
  vcan0  000   [4]  00 00 00 00
  vcan0  001   [4]  01 00 00 00
  vcan0  001   [4]  01 00 00 00
  vcan0  001   [4]  01 00 00 00
  vcan0  002   [4]  02 00 00 00
  vcan0  002   [4]  02 00 00 00
  vcan0  002   [4]  02 00 00 00
  vcan0  003   [4]  03 00 00 00
  vcan0  003   [4]  03 00 00 00
  vcan0  003   [4]  03 00 00 00

$ candump vcan0,0:0,0:0,0:0,J

  setsockopt CAN_RAW_JOIN_FILTERS not supported by your
  Linux Kernel: Protocol not available

##########################################

After applying the two kernel patches:

$ cangen vcan0 -Di -Ii -L4 &

$ candump vcan0,0:0,0:0,0:0

  /* 3 filters, no repeat for each frame (great!) */
  vcan0  000   [4]  00 00 00 00
  vcan0  001   [4]  01 00 00 00
  vcan0  002   [4]  02 00 00 00
  vcan0  003   [4]  03 00 00 00
  vcan0  004   [4]  04 00 00 00
  vcan0  005   [4]  05 00 00 00
  vcan0  006   [4]  06 00 00 00

$ cangen vcan0 -Di -I 123 -L 4

$ candump vcan0,123~7FF

  /* Basic case: no output as all CAN IDs matches 123 */

$ candump vcan0,123~7FF,111~7FF

  /* OR operator working as expected */
  vcan0  123   [4]  00 00 00 00
  vcan0  123   [4]  01 00 00 00
  vcan0  123   [4]  02 00 00 00
  vcan0  123   [4]  03 00 00 00
  vcan0  123   [4]  04 00 00 00
  vcan0  123   [4]  05 00 00 00
  vcan0  123   [4]  06 00 00 00

$ candump vcan0,123~7FF,111~7FF,J

  /* No output; AND operator working as expected */


Regards,
Darwish
