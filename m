From: Felix Obenhuber <felix@obenhuber.de>
Subject: Retrieve amount of queued frames in the txqueue of a interface
Date: Wed, 6 Feb 2013 12:59:21 +0100
Message-ID: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:42839 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab3BFL7Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Feb 2013 06:59:25 -0500
Received: by mail-qa0-f41.google.com with SMTP id hy16so2275002qab.0
        for <linux-can@vger.kernel.org>; Wed, 06 Feb 2013 03:59:22 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

how can I retrive the number of frames currently queued for
transmission on a SocketCAN interface? Is this possible via netlink?

Maybe someone has the answer by hand...

Thanks!

Felix
