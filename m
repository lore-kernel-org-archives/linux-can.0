From: Drew Fustini <drew@beagleboard.org>
Subject: isotp in mainline?
Date: Thu, 11 Jun 2020 17:43:37 +0200
Message-ID: <20200611154337.GA3166627@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPnm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jun 2020 11:43:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0FFC08C5C1
        for <linux-can@vger.kernel.org>; Thu, 11 Jun 2020 08:43:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gl26so6908193ejb.11
        for <linux-can@vger.kernel.org>; Thu, 11 Jun 2020 08:43:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

Hope you are doing well.

I'm reviewing patches we add to our beaglebone kernel build [0] and
remembered that we added isotp for the Macchina P1 adapter [1].

Is there a current effort to get the isotp driver accepted into mainline?

Thanks,
Drew

[0] https://github.com/RobertCNelson/ti-linux-kernel-dev/tree/ti-linux-5.4.y/patches/can_isotp
[1] https://www.macchina.cc/catalog/p1-boards/p1-under-dash
