From: "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Are there any netfilter modules for use with Socket CAN
Date: Sun, 26 Apr 2020 15:07:08 +0300
Message-ID: <CAP22eLGTc6K1auF5JOofTKy83uTOq0hK_qb8fgJ=J78njwWjVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDZMHX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Apr 2020 08:07:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F2C061A0E
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:07:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d17so17116870wrg.11
        for <linux-can@vger.kernel.org>; Sun, 26 Apr 2020 05:07:21 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi list,
From my google search I did not find any netfilter /iptable rule which
allows to filter on CAN fields,  message ID and other.
Please point me in the right direction.

Regards,
Lev
