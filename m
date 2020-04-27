From: "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Is is possible to use Netfilter for outgoing CAN msgs by CAN-ID?
Date: Mon, 27 Apr 2020 13:48:39 +0300
Message-ID: <CAP22eLEefVnmatvz1yn8g09o1v_YRs3NS=_ybhF_-WmquiUaLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgD0Ksw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 27 Apr 2020 06:48:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B0C0610D5
        for <linux-can@vger.kernel.org>; Mon, 27 Apr 2020 03:48:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g13so19948684wrb.8
        for <linux-can@vger.kernel.org>; Mon, 27 Apr 2020 03:48:51 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

Thanks to Chris and Pavel, you helped me to sharpen my question. so I
rephrased my original question and learn things.

 At first glance the answer should be definitely YES.

Since CAN-ID lives in sk_buff and Netfilter hook receives sk_buff as a
parameter there should not be a problem

But I did not find any such module by googling.
