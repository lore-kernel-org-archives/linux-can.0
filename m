From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] Android.mk: canbusload: make use of libcan
Date: Fri, 31 Jan 2014 11:47:24 +0100
Message-ID: <CAGm1_kvHPrRCZjsJHpKb7jj6TGb9RbYLNs-QJUk3o5KzpJb_mg@mail.gmail.com>
References: <1391163924-31563-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:51424 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaAaKrt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 05:47:49 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so2103931bkz.13
        for <linux-can@vger.kernel.org>; Fri, 31 Jan 2014 02:47:47 -0800 (PST)
In-Reply-To: <1391163924-31563-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Jan 31, 2014 at 11:25 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> In commit
>
>     2206f92 canbusload: Add exact CAN frame length calculation (including bitstuffing)
>
> the function to calculate the can_frame_length was moved into a seperate file
> (canframelen.c). This patch for the Android makefile adds canframelen.c to the
> lib, too and lets canbusload link against the lib.
>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Yegor,
>
> can you please test if current master + this patch compiles again on Android?
>
> regards,
> Marc
>
>  Android.mk | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Android.mk b/Android.mk
> index ffac957..1901197 100644
> --- a/Android.mk
> +++ b/Android.mk
> @@ -11,7 +11,7 @@ PRIVATE_LOCAL_CFLAGS := -O2 -g -W -Wall               \
>
>  include $(CLEAR_VARS)
>
> -LOCAL_SRC_FILES := lib.c
> +LOCAL_SRC_FILES := lib.c canframelen.c
>  LOCAL_MODULE := libcan
>  LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
>  LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)
> @@ -86,6 +86,7 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES := canbusload.c
>  LOCAL_MODULE := canbusload
>  LOCAL_MODULE_TAGS := optional
> +LOCAL_STATIC_LIBRARIES := libcan
>  LOCAL_C_INCLUDES := $(LOCAL_PATH)/include/
>  LOCAL_CFLAGS := $(PRIVATE_LOCAL_CFLAGS)

It compiles on Android.

Tested-by: Yegor Yefremov <yegorslists@googlemail.com>

Yegor
