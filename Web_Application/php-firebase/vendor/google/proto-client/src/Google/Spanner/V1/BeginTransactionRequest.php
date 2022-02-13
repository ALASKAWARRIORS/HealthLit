<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/spanner/v1/spanner.proto

namespace Google\Spanner\V1;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * The request for [BeginTransaction][google.spanner.v1.Spanner.BeginTransaction].
 *
 * Generated from protobuf message <code>google.spanner.v1.BeginTransactionRequest</code>
 */
class BeginTransactionRequest extends \Google\Protobuf\Internal\Message
{
    /**
     * Required. The session in which the transaction runs.
     *
     * Generated from protobuf field <code>string session = 1;</code>
     */
    private $session = '';
    /**
     * Required. Options for the new transaction.
     *
     * Generated from protobuf field <code>.google.spanner.v1.TransactionOptions options = 2;</code>
     */
    private $options = null;

    public function __construct() {
        \GPBMetadata\Google\Spanner\V1\Spanner::initOnce();
        parent::__construct();
    }

    /**
     * Required. The session in which the transaction runs.
     *
     * Generated from protobuf field <code>string session = 1;</code>
     * @return string
     */
    public function getSession()
    {
        return $this->session;
    }

    /**
     * Required. The session in which the transaction runs.
     *
     * Generated from protobuf field <code>string session = 1;</code>
     * @param string $var
     * @return $this
     */
    public function setSession($var)
    {
        GPBUtil::checkString($var, True);
        $this->session = $var;

        return $this;
    }

    /**
     * Required. Options for the new transaction.
     *
     * Generated from protobuf field <code>.google.spanner.v1.TransactionOptions options = 2;</code>
     * @return \Google\Spanner\V1\TransactionOptions
     */
    public function getOptions()
    {
        return $this->options;
    }

    /**
     * Required. Options for the new transaction.
     *
     * Generated from protobuf field <code>.google.spanner.v1.TransactionOptions options = 2;</code>
     * @param \Google\Spanner\V1\TransactionOptions $var
     * @return $this
     */
    public function setOptions($var)
    {
        GPBUtil::checkMessage($var, \Google\Spanner\V1\TransactionOptions::class);
        $this->options = $var;

        return $this;
    }

}
