From: Christian Gagneraud <chgans@gmail.com>
Subject: Re: Are there any netfilter modules for use with Socket CAN
Date: Mon, 27 Apr 2020 00:45:54 +1200
Message-ID: <CABxGUTjxAgaMtbp0E1UWiH2HCELNtQ8F_VkT7Ja29Ma0MGK_dg@mail.gmail.com>
References: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725974AbgDZMqG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Apr 2020 08:46:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F628C061A0F
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:46:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id k6so15875324iob.3
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:46:06 -0700 (PDT)
In-Reply-To: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Lev R. Oshvang ." <levonshe@gmail.com>
Cc: linux-can <linux-can@vger.kernel.org>

On Mon, 27 Apr 2020 at 00:08, Lev R. Oshvang . <levonshe@gmail.com> wrote:
>
> Hi list,
> From my google search I did not find any netfilter /iptable rule which
> allows to filter on CAN fields,  message ID and other.
> Please point me in the right direction.

You can do basic filtering with the CAN Gateway
https://cateee.net/lkddb/web-lkddb/CAN_GW.html
https://manpages.debian.org/testing/can-utils/cangw.1.en.html

Hope this helps.
Chris
