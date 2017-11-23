From: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] R-Car D3 (r8a77995) CAN support
Date: Thu, 23 Nov 2017 08:43:18 +0100
Message-ID: <CAO3366xk+Spa=z6bFW9TfqPk_8wUEd5scMK35JbXwpxZ2z7L2w@mail.gmail.com>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com> <20171122181045.5pstmikwp43idts5@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171122181045.5pstmikwp43idts5-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org

On Wed, Nov 22, 2017 at 7:10 PM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Fri, Nov 17, 2017 at 11:41:22AM +0100, Ulrich Hecht wrote:
>> Hi!
>>
>> Here's CAN and CAN FD support for the R-Car D3. This is a by-the-datasheet
>> implementation, with the datasheet missing some bits, namely the pin map.
>> I filled in the gaps with frog DNA^W^W^Wby deducing the information from
>> pin numbers already in the PFC driver, so careful scrutiny is advised.
>>
>> CU
>> Uli
>>
>>
>> Ulrich Hecht (7):
>>   pinctrl: sh-pfc: r8a77995: Add CAN support
>>   pinctrl: sh-pfc: r8a77995: Add CAN FD support
>>   arm64: dts: r8a77995: Add CAN external clock support
>>   arm64: dts: r8a77995: Add CAN support
>>   arm64: dts: r8a77995: Add CAN FD support
>>   can: rcar_can: document r8a77995 (R-Car D3) compatibility strings
>>   can: rcar_canfd: document r8a77995 (R-Car D3) compatibility strings
>
> Hi Ulrich,
>
> is it safe, from a regression point of view, to apply the dts patches
> to a tree that does not have the other patches present?

I believe it is.

CU
Uli
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
