Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331592;
	b=jCeBKySGT9DpETIJg87GGcEkzsifJsmupyOTlV+E8i155Hy+2O6P2ve0F11rjOzVyYHz
	 MQK+uX62ZJzPXKSBDlIoMTX3Zku2nh/R3GD77oZGVU/3qn8pGpS/MHhizcq1uIUH1KRiJ
	 F7bNvgc0WVrArEkVOWfG3BpEciEYNhwTsOFXKZqv8ZIQMGXvB+r58p/SVXvWX80CNQjAU
	 7kFhF9HVxMhMpvdQNRTnOERgWGtOSOsK4rHdtVyXOrMitRaGS7EoE8pBXdeg+SUAtEyjp
	 +OLcIe/DB9YxCIqf8IrTb3LaJ9UEbA/ECKploUO4Rz2cDHX/Tkbp/9PqEl+1L94u3Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331592;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
	b=SNfAbKttvv/fcii1DEIUMXduUGOntEfCoyNkYIIZOfne0AEVevAxJMqRxwrydZ0kMAqk
	 kbKS+PhMrHBvjSYTAIlbCM2nStCxYBcjKfG/e6vWjgSIwW8LO0CZD4j8lj/SvvpFSoECF
	 WpKnspPWaAYNuiRJPKrLZrb0mOx5vGC7L9JoHuAiYXb4zkPTtLfGeVAhk0mT9DwDKU9ZZ
	 vg3Qs7Rx2jaIoVFJ2yf3VjiKtVZesARY71zoQYUbSS7+fWBE0C1Zq80S/UgE9+gFxSomi
	 VG/BrDLH8nH5BJBNJf+6nqrvapj6bBlYXlp+YX9kz08hn7uxaOl/gSZFvM/8JYpYc4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tj0skr00;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BrrYG0IX;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49364606A323
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 17:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49364606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tj0skr00;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BrrYG0IX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794331591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
	b=Tj0skr00V0eP7+ylUEUve3V3jWtNU9QQKLshaxMAP19ngaQ6Hu+jxVt8BTR+4h5HelsV2T
	ZQMaJuK79fYpuv8nJmpynWjXknDAvRNIQpmrrYJU8GGZYgCyqGV8eFkCC9vnIK3bAeLbyT
	QL4IJKhwU6uYI1QYw10mdZq97Ujqs1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-vBV74v3pNFGfNX738m6vSA-1; Tue, 10 Nov 2026 12:26:29 -0500
X-MC-Unique: vBV74v3pNFGfNX738m6vSA-1
X-Mimecast-MFC-AGG-ID: vBV74v3pNFGfNX738m6vSA_1794331588
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4916d47eeb5so1871704f8f.1
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794331588; x=1794936388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
        b=BrrYG0IX5xDbN5YVeeura7PJUFtwGNuDHcT/BZSvplvewOipt/IF9fNbhJmnZ+I12X
         S8HIQIyrE+S0L0SlW16G1/gd7olybX+vExvOKt375BnlG1383c74cfcnd2EEqEe7YUf/
         aLPJw73z5FLvQuQxkWPQpb728MJjhpcAEcSklE0KJjtUj3/4MwfDJKXbRzN76TKcztRs
         VxF1YkkVAb7nE0W3lPyBlfLARR23UwnARpRAdNODK9knuApTi11IeU+EK0XZq7gkMdXg
         vmGfkF9wTG/UL/TBNJZOLq02I1kgmUIg8rWUMXTTPAheKPMrucr3MV2s8Gy9QiaZVKAX
         4S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794331588; x=1794936388;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKRRknjMWCPzWVN1v0/d1lk7IVipZL2/q4GtTn0t/go=;
        b=qzrPgEyDPsLx4oXhVWWv9Sgbm885OACRiKAUdLI4YKO3udo86SrHn1Jrx9G63+9aRo
         /oNrCfOknCXqr1gIQSRzqeBbf8nJcr8IloSvNwhr8bFZS7gjenJXR7k7gLpcOYP+HMuV
         49ClCVj19aDDEkgYcay/cz1N+0etsLkSsGafNUvN+4bbwFnM6uwHLmTnp+p2/zWlTRdB
         UJTEw9Ec+WtuGTQrfeda0jslcUMQQQBKOq86nbNQnpAZyp7Dj5Klaq4W6OET9LE2LhJ7
         s1kpxYPXW36faOvj29BD5oQoTIXIJLVsskkx/8VDylRRidm++8Jc9hah39+WaSy+AeWV
         lCUQ==
X-Forwarded-Encrypted: i=1; AL+hErGNRlGAEOM7Mw3B8/NpVT5SqpAxyZR09t+VQrAFOeitNN5DYw5I2qTEV7up0AwGCY00vFdECiNr/eU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JpVYIdG1CU2AdlxjcBAPqHgpkwgRkZINbCeqcYpvzI1NxMjwV
	LBzxubFL/zsVJ29pFaGhIFjwQfQoQZSY/S2dMTyZp8hhbMe0UzcX84h6FaxQSDfaetPwvT4BO0K
	poqqgClNAadv6QBQ7mXkal4M3UAp8OLSqIAab4/jbiBCFKURFzTHEka4CtO2D8w==
X-Gm-Gg: AYBFou3+L3NG3cFEZCuIhXx/G7UnyXn0TBUhW2zR1SNDoIL5ro9qG5+UB4nEPyE8vHp
	5nOf3GMyyrSzpWl/g3b7W/oCBpg0EBU3y5XPazcOcho9i4s5bDVwWbi5S3rFyfzkb5DH7eb+9xQ
	7khEy+jUJOO6koTeVfHU9poZ+VpUZSviH/Jy04rCYnmvIZTt0CbDh+qF4YDZvHFn67J9w3C3aV6
	jVnChoMPdIqmg8R61thiv8bL7CeEGmw3/TpBCtTEa7JXTPXkIFDsSzDTxUeQCTMKmMHmcpt4D/2
	bpc+uJpceOz4uka+2/KgB0nGd1LpALvDSmrEV3vJ1+DR8XAou9MHbm+0iXDoRYW3mXkgn8B8D/y
	gWXnR2tHwxu2XkQLJRqx148jxoAbchZGu2rzUarcwgQ==
X-Received: by 2002:a5d:5f86:0:b0:491:f34b:49b4 with SMTP id ffacd0b85a97d-498309aeeb5mr6440921f8f.44.1794331588107;
        Tue, 10 Nov 2026 09:26:28 -0800 (PST)
X-Received: by 2002:a5d:5f86:0:b0:491:f34b:49b4 with SMTP id ffacd0b85a97d-498309aeeb5mr6440867f8f.44.1794331587415;
        Tue, 10 Nov 2026 09:26:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm6152831f8f.44.2026.11.10.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:26:26 -0800 (PST)
Date: Tue, 10 Nov 2026 12:26:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: forfortuna@naver.com
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Francesco Valla <francesco@valla.it>,
	virtualization@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] can: virtio: fix virtqueue use before DRIVER_OK
Message-ID: <20261110122457-mutt-send-email-mst@kernel.org>
References: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com>

On Wed, Nov 11, 2026 at 02:11:13AM +0900, Seonghyeon Lim via B4 Relay wrote:
> From: Seonghyeon Lim <forfortuna@naver.com>
> 
> virtio_can_probe() and virtio_can_restore() fill the RX virtqueue and
> kick it before the device is set DRIVER_OK. The virtio specification
> does not allow the driver to notify the device before DRIVER_OK.
> 
> In restore, if the interface was up, virtio_can_open() then sends a
> START control message and waits for the reply. DRIVER_OK is only set
> by the virtio core after restore returns, so the device may never
> handle the request and the wait never completes, which hangs system
> resume. In probe, an ndo_open() right after register_candev() can
> likewise send the START message before DRIVER_OK.
> 
> Call virtio_device_ready() before the first virtqueue use in both
> probe and restore, as virtio-net does.
> 
> Fixes: 083082a4e6d8 ("can: virtio: Add virtio CAN driver")
> Signed-off-by: Seonghyeon Lim <forfortuna@naver.com>

however, device ready means you can get callbacks: config
and vq.


did you audit the driver to make sure this is safe while
probe did not yet populate and register the device?

> ---

> Tested with QEMU 8.2 + vhost-device-can: with the CAN interface up,
> suspend/resume (pm_test=devices) hangs without this patch and
> completes with it. No new lockdep warnings.
> ---
>  drivers/net/can/virtio_can.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> index f67d0bf09681..ae35a00b784b 100644
> --- a/drivers/net/can/virtio_can.c
> +++ b/drivers/net/can/virtio_can.c
> @@ -912,6 +912,9 @@ static int virtio_can_probe(struct virtio_device *vdev)
>  		err = -ENOMEM;
>  		goto on_failure;
>  	}
> +
> +	virtio_device_ready(vdev);
> +
>  	virtio_can_populate_rx_vq(vdev);
>  
>  	err = register_virtio_can_dev(dev);
> @@ -966,6 +969,9 @@ static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
>  		virtio_can_del_vq(vdev);
>  		return -ENOMEM;
>  	}
> +
> +	virtio_device_ready(vdev);
> +
>  	virtio_can_populate_rx_vq(vdev);
>  
>  	if (netif_running(ndev)) {
> 
> ---
> base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
> change-id: 20261111-virtio-can-ready-85cefff06a84
> 
> Best regards,
> --  
> Seonghyeon Lim <forfortuna@naver.com>
> 

