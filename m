Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4D5505EF
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093272; cv=pass; b=i7jEj8JCs6Al4FIRF59olTcaw82w6dF6+PKAL/dnuEfziGyNI+u/VKc+kps6g8e4zBHfVQX3DIDkhe4fRbhplFzLbK1TyyrugtOwamrodqbDn+Fz6VbEN42yrlvQTHoKXS40OMZ+XvXqjkCmwxdEiVhwNU6wn6zfEmFOKyXDqB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093272; c=relaxed/simple;
	bh=Cj7HQl7QGpxlCPxDXPPabF3DG6gjvcEl+sPCkBMHEoY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=sk30xUouUqlg8r55OErLzmHQHXuo9uu/HkleLrS9gs89e+GDiaKGIvCnWaK+kpRGtImyBh6AfC9xINJEFYfJlP+bFMsqHlMjaJ+x4IzpUpzqX7pM1ddd/aUxcTEZbc+0wpPqKJ+7zWr4RqFLxFWL+rjdmTbksu8Le04pGjv4CN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Q3Jw8iKb; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Q3Jw8iKb"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E1A6D200467;
	Thu, 15 Oct 2026 21:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792093268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODv2+lV9BygLrviVvMw5bcD4DPAAn6vq6bRKfpjfZX8=;
	b=Q3Jw8iKb6Xe279vTmgYDdz1ySfhBEj076vxP8YmNsOZCi9iYXNQlD6nvsEjFVUxIh4Af43
	5V2aREkDO6kzgr58uiGlXzEOs4LVtXwqeP/SCQApHYOoNDy59AplEbm7TqxjY1wj83VoAx
	qwPHeFPyMcCRE92k0+41+YHnO1Ab9kZssBSBRU63aQ5bRdzzfxcbh91ELp9dvEFqIqnYOD
	CM4J+QYZvWZwwLxsz+OhxcXNQnmv6rseS5ExVHXtrwRaF3tkkLKJCC2g4Ej529UHqct/rz
	z3pn+FrZP0A0otCFmsdHj1UvOWFMppTGnXs4fs2zwEdY6k19dXD5RfT6lxDVVw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792093268; a=rsa-sha256;
	cv=none;
	b=grCEiKLDkvaDO3TIu07l1HTw5a9Kuox+koClFt9ZRPggC59yNkziK8mP655hlcHBfH5arb
	tcPTav1VdHUvR70InTq0ssCu9nREivO33VXbq1iUVrqXba8kHnpJ+JD1yvD5XRPMwkVdqa
	CMK3sTcw2Pn2H4A32oLu5ql++C+a6rWzPov9/lnyiGqyhyKOLSu2KcliCC2vdhmwv4bj7U
	hJnmhCEl2jlp9ySI1PqJUjK2q7iwyQO20V78E37Oazhnb1OKeVSPa1uHVdPFasMwk0UdoE
	W3M4n0tnK3OoPETJilA4h/uy24Rl42Fg4FAXO/gAp7hYvtBWDJ5zOuhH/Do/pQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792093268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODv2+lV9BygLrviVvMw5bcD4DPAAn6vq6bRKfpjfZX8=;
	b=GNSDOidV/+QB4sJ5FMimRpZGBDqrDulvEpl0OJ01XsKiOidG4cIX+tUW4jmeAfVgOWHhtM
	1x4IM4Vyw7tyCxsYJPBggFZE5Nrz1Sp21+iICeNeics54y5JtqE2kObzFz1f7cjmKJxbyh
	BrYAXzmZiEbb0EG+7hapAl4qrcd3jG90sNgIFUrMSfxI61lOHYAKS37lRjk5JmyDu6Z15f
	zcIbEjTZsxm9ZgSwaLao6NyBuXjk2Ei44wjdPGezpGnehRObOafErHsFB92UoVbc1RoaKu
	75bxZ0gfC580Fof8UgaFsJxgMLNb1MtFF2k82fw2gByS+fi5OSg6h0CT+aVkfw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHRK8-0064Xk-2f;
	Thu, 15 Oct 2026 21:41:08 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8A6B35C569C;
	Thu, 15 Oct 2026 19:41:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC 1/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): add newfunction to be called from
 within loop of threaded interrupt handlers
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20261005105308.878221F000FF@smtp.kernel.org>
References: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
 <20261005-upstream-can-rx-offload-batching-alternative-v1-1-4c08ccb516ec@pengutronix.de>
 <20261005105308.878221F000FF@smtp.kernel.org>
Date: Thu, 15 Oct 2026 21:41:03 +0200
Message-Id: <179209326383.1183727.6084243947036038150.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Cj7HQl7QGpxlCPxDXPPabF3DG6gjvcEl+sPCkBMHEoY=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6qBNgwD/TM8NVWZLhz+Xq4nXxFkbmJfdvdDBsuMfyu
 +N1g8rPjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEzE4zAjw1Z74U6uu+8Y7f4U
 znH4KVyQraViUFO8x1OEx/+sQcKvowz/zC7kztY9oXPqpkKQb2j2+YuNhY3hlSXf5Q93Waapb1z
 MCQA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-10-05 10:53 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] can: stale flush_len causes skb_queue.qlen underflow and permanent packet drops

> > + */
> > +static inline void __skb_cut_position(struct sk_buff_head *list,
> > +				      struct sk_buff_head *head,
> > +				      struct sk_buff *entry,
> > +				      __u32 qlen)
> > +{
> > +	struct sk_buff *new_first = entry->next;
> > +	struct sk_buff *first = head->next;
> > +
> > +	WRITE_ONCE(list->next, first);
> > +	WRITE_ONCE(list->next->prev, (struct sk_buff *)list);
> > +	WRITE_ONCE(list->prev, entry);
> > +	WRITE_ONCE(entry->next, (struct sk_buff *)list);
> > +	list->qlen = qlen;
> > +
> > +	WRITE_ONCE(head->next, new_first);
> > +	WRITE_ONCE(new_first->prev, (struct sk_buff *)head);
> > +	head->qlen -= qlen;
>
> [Severity: High]
> Could this lead to list->qlen undercounting the elements passed to NAPI?
>
> If an older out-of-order CAN frame is inserted into skb_irq_queue before
> offload->flush_skb after flush_len has been cached, the physical list
> splice moves more than qlen elements up to entry. Statically updating the
> length counters using the stale qlen will cause an eventual underflow in NAPI
> dequeue.

pw-bot: cr

Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
