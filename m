Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F04F0559
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166446; cv=none; b=sqpjBpXUdUZguiqpkC6BR4HbfEncY0c9/jrVe7Io9Cg9eoDb5q9unn79u+5ztodWy0tJFUzg/iEE5CwWhjKkLZ76AGupkmDj8piLFmmAK6fXCTJq6ThFbZ8h7DcVyCzvrVGTWeYk1QOtINYY9KN7kxPHfqzXRwNMKoMmNTYK9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166446; c=relaxed/simple;
	bh=4y3egpqOY/nZk+J0/RYz4bR21HyXzVScWN2wyjhJufs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPXyqOjnuYjO1wRF/sxFElvg4ULYU16/6ovYlZidZu2eh21wk+BlsNa7cj6m2twtGjQ3dcbGKE/UYvA2onQtLFMZhnQ72zc1pbELGQhPEtW6sntw+qZJEHAf3/LDU4ltL4+Bsfv0NG0i3tBgI1+7i6o4/fL19DCmZaPoJRBMF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KxBRsEOR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t3jVBgNN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxBRsEOR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t3jVBgNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792166444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dl4M40l9nHxXIvI25ccoxXnkcqQS9fDj14w2LQVggOo=;
	b=KxBRsEOR+hnM9wD9nrd9DfP/MLFm+h/zb6imsoq5pKwE8TIHAdkExhEqbJ+pCHbmUbSmVr
	r6vLreowZSyBLmXjvOhx0HkMU5zNBuXrFtPMnog50/CVeJTdmpkARj98mv4m3b8761wH49
	uDtoQbkfcY4Y7Ob9Q/2lc/hG2mRSUuU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-rXxRFcRNM1OlpaOJ9gDfbA-1; Fri, 16 Oct 2026 16:00:41 +0000
X-MC-Unique: rXxRFcRNM1OlpaOJ9gDfbA-1
X-Mimecast-MFC-AGG-ID: rXxRFcRNM1OlpaOJ9gDfbA_1792166440
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a166a9ea21so725455e9.2
        for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 09:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792166440; x=1792771240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dl4M40l9nHxXIvI25ccoxXnkcqQS9fDj14w2LQVggOo=;
        b=t3jVBgNNmJedVUd/oHA9VhE+RDXKCM8qZCEEvAgJ0xlfqz3Erny/3V4Wt7ojFVEg1u
         mK0rPEAb4QXCDIhtiEcZnc+SMqu08i+egiuZ7b6HOsQvbGsjySAwl2xdyFS60bBxhYqh
         fruW17J6KgGLdNFoPVlaUHjffpjwmgp9cz1Buh88K6ry5NLYALNcyeSTcFVTySCeViNQ
         B1JHy1UzC26tg/AAywXs4XIV6r+TTyejOVSuTXKras0kF5O6LVRIaEJOV05JK/Vumtzn
         xdn58IRg85xatkSGNaffGnWnZQKwGFXArC4lB0kSyiytrXstQfzmOov319eTG9J9dz3e
         Twhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166440; x=1792771240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dl4M40l9nHxXIvI25ccoxXnkcqQS9fDj14w2LQVggOo=;
        b=0uKugu/SP6CqE0oCxtzuFYJ4PCuclgTYfvw/y6Q87TCbhFWW06voev6NKqnO+chFKi
         k6m/r9DXkAlbc2TFGjZUJSVKCxpA0tmOgzjX79lZZrMDR7c9PdLreU4O7lr4xxE+5OuP
         4Xg2f1O4raUkKeTKo11fFoKep9XBH+wXislx3wG2vO+/A7i17OSMXPYlsr9TXIU5M3qK
         iMkV8ckDahrJ31i8CiMquZJl0XO7Yii2Gnfej/6DXhKTlu/Ua+UVdB6I58+upUVQZZ+j
         ZmPSxXEtUMBnEHUzICWfcurAMDDKLIjkB3WnFv0e2xvi5ICZw8O4i+qdNmNSciMSPNTh
         2Pzw==
X-Forwarded-Encrypted: i=1; AKwUvBwPJa6xEPGblQMncGqgHK6y9m2Y0ko8uSE0I9h7Ewj1Uot7ekYzwaygz+Ano/jCtDe9s3Yk1yCEjfI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhxmDQ/+dQlcIwGZMRWLcbw/KXvjRsUhIwwlWDksAylpkhPs89
	H9X7cmnbALpJrQ4TMiRCKyKuKLWnY8Z+NV/GLkoUmP6wl5UBg06Yu2aXsUVp7/Zw2NR+Vpc/DAv
	yG4jn+HUbdAI6YTx/zxyqQjLXhNkyEk6kF/JDHB7VTN5Yhmt3gC+4c+HT0vnxsQ==
X-Gm-Gg: AYBFou2pDavC9tI8H5w99VzZ+Q/VYx5CKshvxz3W0cHs+DXs+gYUidp+J0JG45thYrH
	lX8+4Kp1HhJ2jqw4iYOU7b2HN38o+PgHHGFigFRCSswQDKCWfKbGivGPJKBTJ01tTSt99bvjI/3
	69pMydL9R59/qnc570eUuoNQoROGsW1OM/UA4n/Ze350YOAMW1dS5JH/aJU938+EZxbyEgTcB6P
	BfU+y2LQMaxtXCLdFFyHuT39U0cOp0ckQWnDQOy/5XJy/1idF0Gm5wMBn4qx6BFF+EtFL3N4iTf
	8SjHzqeHQ7siUL+kvnr9iH4fyNZCZagJV9tVkrhd+qvyCQv7JWPkVWOycWKiNj/R57Rd04WxMAL
	NONrwVg==
X-Received: by 2002:a05:600c:64c5:b0:4a1:d1f7:bea with SMTP id 5b1f17b1804b1-4a1d7603dddmr5402325e9.17.1792166440165;
        Fri, 16 Oct 2026 09:00:40 -0700 (PDT)
X-Received: by 2002:a05:600c:64c5:b0:4a1:d1f7:bea with SMTP id 5b1f17b1804b1-4a1d7603dddmr5401715e9.17.1792166439696;
        Fri, 16 Oct 2026 09:00:39 -0700 (PDT)
Received: from storniolo-redhat ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cbedb6f7sm70020225e9.2.2026.10.16.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:00:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 18:00:36 +0200
From: Filippo Storniolo <fstornio@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Message-ID: <atJHPuFD8dZyoDaj@storniolo-redhat>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
 <20260904142606.6FB371F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904142606.6FB371F00A3D@smtp.kernel.org>

On Fri, Sep 04, 2026 at 02:26:05PM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Medium] Index-based resumption in can_diag_dump() causes skipped or repeated sockets without notifying userspace via NLM_F_DUMP_INTR.
>--
>
>commit 8ae9bc3a24d9d75317a64a778b0ca0dc88c6a32a
>Author: Filippo Storniolo <fstornio@redhat.com>
>
>can: add can diag interface
>
>Add the can_diag interface for querying sockets from userspace. The ss(8)
>tool can use this interface to list open sockets. The userspace ABI includes
>netlink request and response structs with socket information fields.
>
>> diff --git a/net/can/diag.c b/net/can/diag.c
>> new file mode 100644
>> index 0000000000000..647a94636a548
>> --- /dev/null
>> +++ b/net/can/diag.c
>
>[ ... ]
>
>> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
>> +{
>> +	int num = 0, s_num = cb->args[0];
>> +	struct can_diag_req *req;
>> +	struct net *net;
>> +	struct sock *sk;
>> +
>> +	net = sock_net(skb->sk);
>> +	req = nlmsg_data(cb->nlh);
>> +
>> +	lock_can_diag_mutex(net);
>> +	sk_for_each(sk, &net->can.sklist) {
>> +		if (num < s_num)
>> +			goto next;
>> +
>> +		if (sk_diag_fill(sk, skb, req,
>
>[Severity: Medium]
>Will this simple index-based resumption (num < s_num) cause skipped or
>repeated sockets without notifying userspace if the list is modified between
>dump iterations?
>
>A netlink dump of CAN sockets can require multiple messages, forcing
>can_diag_dump() to return and resume later. If a concurrent thread creates
>or destroys a CAN socket, altering the layout of net->can.sklist while the
>mutex is dropped, iteration by index becomes inaccurate.
>
>According to the Netlink uAPI guidelines, if iteration during a dump may skip
>or repeat objects, NLM_F_DUMP_INTR must be set on the affected messages. This
>is normally implemented by maintaining a generation counter and recording it
>in cb->seq to detect list modifications.
>
>> +				 sk_user_ns(NETLINK_CB(cb->skb).sk),
>> +				 NETLINK_CB(cb->skb).portid,
>> +				 cb->nlh->nlmsg_seq, NLM_F_MULTI,
>> +				 sock_i_ino(sk)) < 0)
>> +			goto done;
>> +next:
>> +		num++;
>> +	}
>> +done:
>> +	unlock_can_diag_mutex(net);
>> +	cb->args[0] = num;
>> +
>> +	return skb->len;
>> +}
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com?part=3
>

I understand the concern, but as far as I can tell no other diag
handler implements this.  Does it make sense to add it only here rather
than as a follow-up done uniformly across all the diag handlers?

@Marc Kleine-Budde @Oliver Hartkopp what do you think about this?
If you think it could be worth adding this feature, I can do a respin.

Best regards,
Filippo

